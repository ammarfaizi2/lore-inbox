Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136501AbRD3RJX>; Mon, 30 Apr 2001 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136500AbRD3RJN>; Mon, 30 Apr 2001 13:09:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20800 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136501AbRD3RJC>; Mon, 30 Apr 2001 13:09:02 -0400
Date: Mon, 30 Apr 2001 19:07:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Magnus Naeslund(f)" <mag@fbab.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
Message-ID: <20010430190747.C19620@athlon.random>
In-Reply-To: <20010430014653.C923@athlon.random> <E14uGya-0008He-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14uGya-0008He-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 30, 2001 at 05:56:41PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 05:56:41PM +0100, Alan Cox wrote:
> > On alpha it's racy if you set CONFIG_ALPHA_LARGE_VMALLOC y (so don't do
> > that as you don't need it). As long as you use only 1 entry of the pgd
> > for the whole vmalloc space (CONFIG_ALPHA_LARGE_VMALLOC n) alpha is
> > safe.
> 
> Its racy for all cases on the Alpha because the exception table fixes are
> not done.

you're talking about the module races, I was only talking only about
vmalloc lazy pgd mapping, they're different things even if they are
both related to the page fault hanlder.

I don't use modules on the alpha so...

> > OTOH x86 is racy and there's no workaround available at the moment.
> 
> -ac fixes all known problems there 

I will check that shortly, thanks. (so far all the fixes I seen floating
around for such races were wrong)

Andrea
