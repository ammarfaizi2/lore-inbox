Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319117AbSHGSbt>; Wed, 7 Aug 2002 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319122AbSHGSbt>; Wed, 7 Aug 2002 14:31:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40197 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319117AbSHGSbs>;
	Wed, 7 Aug 2002 14:31:48 -0400
Date: Wed, 7 Aug 2002 19:35:04 +0100
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@debian.org, rusty@rustcorp.com.au, george@mvista.com,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: softirq parameters
Message-ID: <20020807193504.I24631@parcelfarce.linux.theplanet.co.uk>
References: <20020804.223746.89817190.davem@redhat.com> <20020807152423.3577a5cc.rusty@rustcorp.com.au> <20020807192314.H24631@parcelfarce.linux.theplanet.co.uk> <20020807.111843.15996855.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020807.111843.15996855.davem@redhat.com>; from davem@redhat.com on Wed, Aug 07, 2002 at 11:18:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 11:18:43AM -0700, David S. Miller wrote:
> I'm starting to become leery about this percpu stuff, which ends up
> moving critical data structures (in this case softnet) out of the main
> kernel image (and thus out of the single large PAGE_SIZE entry many
> platforms use to map that part of the kernel).
> 
> Since all the per-cpu stuff ends up in the same cluster of bootmem
> it probably doesn't matter so much.  Here's to hoping that's true :-)

Hrm, I didn't realise what the implementation of percpu was... does it
work for modules?

-- 
Revolutions do not require corporate support.
