Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVCODjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVCODjV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVCODjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:39:21 -0500
Received: from [220.248.27.114] ([220.248.27.114]:47055 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262228AbVCODid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:38:33 -0500
Date: Tue, 15 Mar 2005 10:56:14 +0800
From: hugang@soulinfo.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, rjw@sisk.pl, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [swsusp/ppc] Re: What's going on here ?
Message-ID: <20050315025614.GA28481@hugang.soulinfo.com>
References: <1110847432.5863.57.camel@gaston> <20050315010700.GA1357@elf.ucw.cz> <1110853186.5863.70.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110853186.5863.70.camel@gaston>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 01:19:46PM +1100, Benjamin Herrenschmidt wrote:
> 
> > rjw and hugang did (pretty neccessary) changes to base swsusp (pagedir
> > table -> pagedir linklist), that unfortunately needed update to all
> > the assembly parts. It was series 1/3 update core, i386 and x86-64,
> > 2/3 update ppc, 3/3 introduce initramfs.
> > 
> > This is the offending patch I believe (but the version that was merged
> > was From: me, without code changes).
> > 
> > I realized that patch does more than changing from table to linklist,
> > but it looked mostly okay, so I forwarded it. Sorry.
> 
> It does more than that ... it _adds_ swsusp to ppc ! swsusp wasn't in
> mainline at all for ppc because I consider it not ready. And even the
> asm change should go through me anyway since i wrote that code and I'm
> not sure they know all the possible "issues" with that code.
> 
> > So, what to do now?
> > 
> > a) just revert it
> > 
> > or
> > 
> > b) revert pmac_setup.c and via-pmu parts and Kconfig part
> > 
> > or
> > 
> > c) just disable Kconfig part and fix it up with incremental patches

I hope that's can merge into, It works fine in my PowerBook G4.

> 
> I'll decide later today. I may well keep it and do the cleanup I had in
> mind on top of this, which means merging the pmac suspend-to-ram with
> the common infrastructure. But that will need some changes & hooks to
> the core swsusp.
> 
> Ben.


-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
