Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265672AbUFDJd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265672AbUFDJd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUFDJd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:33:57 -0400
Received: from gprs214-121.eurotel.cz ([160.218.214.121]:3968 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265672AbUFDJdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:33:53 -0400
Date: Fri, 4 Jun 2004 11:33:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040604093344.GA700@elf.ucw.cz>
References: <20040603131007.GB3915@openzaurus.ucw.cz> <4BC449CD20D638indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BC449CD20D638indou.takao@soft.fujitsu.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Although I know about LKCD and netdump, I'm developing yet another crash
> >> dump, which is a polling-based disk dump as netdump do. Because it
> >> disables any interrupts during doing dump, it can avoid lots of problems
> >> LKCD has.
> >> 
> >> Main Feature
> >> - Reliability
> >>    Diskdump disables interrupts, stops other cpus and writes to the 
> >>    disk with polling mode. Therefore, unnecessary functions(like
> >>    interrupt handler) don't disturb dumping.
> >
> >Hmm... with this, better design of swsusp mifht be feasible.
> 
> I don't know mechanism of swsusp well.
> Do you mean diskdump is useful when saving system memory to the disk?

Yes. Self-contained code accessing disk would be usefull both when
saving system memory and when reading it back. (This is probably 2.8
material, through).
							Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
