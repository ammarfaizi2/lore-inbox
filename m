Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281690AbRKUKSq>; Wed, 21 Nov 2001 05:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281565AbRKUKSh>; Wed, 21 Nov 2001 05:18:37 -0500
Received: from sun.fadata.bg ([80.72.64.67]:42501 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S281690AbRKUKS3>;
	Wed, 21 Nov 2001 05:18:29 -0500
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: slab: avoid linear search in kmalloc? (GCC Guru wanted :)
In-Reply-To: <20011121024525.A18750@lina.inka.de> <873d38wkmo.fsf@fadata.bg>
	<3BFB725C.7468088A@redhat.com>
From: Momchil Velikov <velco@fadata.bg>
Date: 21 Nov 2001 11:34:48 +0200
In-Reply-To: <3BFB725C.7468088A@redhat.com>
Message-ID: <87wv0kv553.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Arjan" == Arjan van de Ven <arjanv@redhat.com> writes:

Arjan> Momchil Velikov wrote:
>> 
>> >>>>> "Bernd" == Bernd Eckenfels <ecki@lina.inka.de> writes:
>> 
Bernd> Hello,
Bernd> I noticed that kmalloc and kmem_find_general_cachep are doing a linear
Bernd> search in the cache_sizes array. Isnt it better to speed that up by doing a
Bernd> binary search or a b-tree if like the following patch?
>> 
>> Here is a patch using a gcc extension. gcc generates binary search for the case.

Arjan> the big "case" statement makes you wonder if ffz(~size) would do the
Arjan> same ;)

*Nod*, espesially on architectures, where it is a single instruction.

OTOH, this is possible only if the sizes are powers of two. And they
could be more closely sparsed ...

Regards,
-velco

