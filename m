Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281543AbRKUJXC>; Wed, 21 Nov 2001 04:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281506AbRKUJWm>; Wed, 21 Nov 2001 04:22:42 -0500
Received: from t2.redhat.com ([199.183.24.243]:36091 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S281441AbRKUJWh>; Wed, 21 Nov 2001 04:22:37 -0500
Message-ID: <3BFB725C.7468088A@redhat.com>
Date: Wed, 21 Nov 2001 09:22:36 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slab: avoid linear search in kmalloc? (GCC Guru wanted :)
In-Reply-To: <20011121024525.A18750@lina.inka.de> <873d38wkmo.fsf@fadata.bg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Momchil Velikov wrote:
> 
> >>>>> "Bernd" == Bernd Eckenfels <ecki@lina.inka.de> writes:
> 
> Bernd> Hello,
> Bernd> I noticed that kmalloc and kmem_find_general_cachep are doing a linear
> Bernd> search in the cache_sizes array. Isnt it better to speed that up by doing a
> Bernd> binary search or a b-tree if like the following patch?
> 
> Here is a patch using a gcc extension. gcc generates binary search for the case.

the big "case" statement makes you wonder if ffz(~size) would do the
same ;)
