Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314486AbSEHPtf>; Wed, 8 May 2002 11:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314492AbSEHPte>; Wed, 8 May 2002 11:49:34 -0400
Received: from ns.suse.de ([213.95.15.193]:30215 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314486AbSEHPtc>;
	Wed, 8 May 2002 11:49:32 -0400
Date: Wed, 8 May 2002 17:49:25 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Engebretsen <engebret@vnet.ibm.com>
Cc: justincarlson@cmu.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, anton@samba.org, davidm@hpl.hp.com,
        ak@suse.de
Subject: Re: Memory Barrier Definitions
Message-ID: <20020508174924.A32610@wotan.suse.de>
In-Reply-To: <E175BY8-0008S4-00@the-village.bc.nu> <1020809750.13627.24.camel@gs256.sp.cs.cmu.edu> <3CD89247.8ECB01A4@vnet.ibm.com> <3CD943CE.296717DF@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 10:27:10AM -0500, Dave Engebretsen wrote:
> I am curious what the definition of memory barriers is for IA64, Sparc,
> and x86-64.  
> 
> >From what I can tell, sparc and x86-64 are like alpha and map directly
> to the existing mb, wmb, and rmb semantics, incluing ordering between
> system memory and I/O space.  Is that an accurate assesment?

I don't think it is true for alpha, but it is true
for x86-64. x86-64 by default has strong ordering for most loads/stores.
It is possible to use weak ordering for special marked stores. For that
there are special read and write and read/write barriers which apply
to all memory (not distinction between io space and other memory). In 
addition there is a way to mark special memory areas as write combining and
some other settings, but that is ordered by the normal barriers too.

-Andi

