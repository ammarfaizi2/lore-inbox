Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbTAUPfL>; Tue, 21 Jan 2003 10:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbTAUPfL>; Tue, 21 Jan 2003 10:35:11 -0500
Received: from [195.39.17.254] ([195.39.17.254]:772 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266078AbTAUPfK>;
	Tue, 21 Jan 2003 10:35:10 -0500
Date: Tue, 21 Jan 2003 16:15:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsuspend: possible with VIA Eden processor? Or alternatives?
Message-ID: <20030121151524.GA2487@elf.ucw.cz>
References: <b0c20t$rt$1@fritz38552.news.dfncis.de> <20030120125100.GA27330@codemonkey.org.uk> <b0h6qr$hqs$1@fritz38552.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0h6qr$hqs$1@fritz38552.news.dfncis.de>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > the swsuspend mini howto says that a processor with pse/pse36 feature 
> > is > required for swsupend in 2.4.
> > > 
> > > So I am obviously out of luck with 2.4 kernels, but what about 2.5 (the 
> > > mini-howto is silent here)?
> >
> >>From include/asm-i386/suspend.h
> >
> >static inline void
> >arch_prepare_suspend(void)
> >{
> >    if (!cpu_has_pse)
> >        panic("pse required");
> >}
> >
> I assume this is from a 2.5 kernel (I have no source tree available 
> here). I'll check that tomorrow in the office.

If it is not in 2.4.X it only means 2.4.X will randomly flip bits in
memory during resume.

> >There's really no requirement that you *need* PSE to be able to
> >do suspend, but it seems no-one has stepped forward to write the
> >necessary code to support non-PSE afaics.
> >
> I don't even know what pse means :-(

4MB pages, basically.

[Hey, this is great time to learn something new!]
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
