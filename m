Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUBUStM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 13:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUBUStM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 13:49:12 -0500
Received: from gprs159-17.eurotel.cz ([160.218.159.17]:50560 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261601AbUBUStJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 13:49:09 -0500
Date: Sat, 21 Feb 2004 19:48:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
Message-ID: <20040221184857.GE277@elf.ucw.cz>
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net> <Pine.LNX.4.58.0402181502260.18038@home.osdl.org> <20040221141608.GB310@elf.ucw.cz> <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org> <20040221173449.GA277@elf.ucw.cz> <Pine.LNX.4.58.0402210944050.3301@ppc970.osdl.org> <m18yiwl1pd.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18yiwl1pd.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Sat, 21 Feb 2004, Pavel Machek wrote:
> > >
> > > I'm just afraid that someone will mail you a patch replacing that with
> > > >> 32 and you'll overlook it.
> > 
> > Well, the good news is that ">> 32" should cause gcc to complain with a 
> > big warning (exactly because it's undefined brhaviour on a 32-bit 
> > architecture), so I don't think it's easy to overlook.
> 
> What is wrong with the original?
> 
> -       wrmsr(MSR_IA32_UCODE_WRITE, (unsigned int)(uci->mc->bits), 0);
> 
> I don't see how anything else could be correct.
> 
> Either we have high bits we need to worry about in 32bit mode, in which
> case the 32bit variant is wrong.  Or we don't have high bits to worry
> about in which case attempting to set them is wrong.

I believe that driver is now shared between i386 and x86-64.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
