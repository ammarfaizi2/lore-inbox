Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWFLIKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWFLIKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWFLIKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:10:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:52122 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750779AbWFLIKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:10:12 -0400
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386: use C code for current_thread_info()
References: <200606111512_MC3-1-C229-37D@compuserve.com>
	<Pine.LNX.4.61.0606112141440.9782@yvahk01.tjqt.qr>
	<200606112144.26705.s0348365@sms.ed.ac.uk>
From: Andi Kleen <ak@suse.de>
Date: 12 Jun 2006 10:10:09 +0200
In-Reply-To: <200606112144.26705.s0348365@sms.ed.ac.uk>
Message-ID: <p73slmasske.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:

> On Sunday 11 June 2006 20:42, Jan Engelhardt wrote:
> > >Using C code for current_thread_info() lets the compiler optimize it.
> > >With gcc 4.0.2, kernel is smaller:
> > >
> > >    text           data     bss     dec     hex filename
> > > 3645212         555556  312024 4512792  44dc18 2.6.17-rc6-nb-post/vmlinux
> > > 3647276         555556  312024 4514856  44e428 2.6.17-rc6-nb/vmlinux
> > > -------
> > >   -2064
> >
> > If possible, can you or someone post the results for x86_64?
> 
> Patch is for i386, x86_64's current_thread_info() is already C.

Actually read_pda() is inline assembly. But so far gcc/binutils don't support
%gs references in the way the kernel needs it directly, so it has 
to stay this way.

-Andi
