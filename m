Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbTCJRFK>; Mon, 10 Mar 2003 12:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbTCJRFK>; Mon, 10 Mar 2003 12:05:10 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13730 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261366AbTCJRFJ>;
	Mon, 10 Mar 2003 12:05:09 -0500
Date: Mon, 10 Mar 2003 10:51:21 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
In-Reply-To: <20030307203650.GB2447@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0303101049290.1002-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The cumulative patch is here:
> > 
> > http://kernel.org/pub/linux/kernel/people/mochel/power/pm-2.5.64.diff.gz
> 
> Hmm, I am not sure if drivers/power is the right place for stuff like
> fridge.c. That might be usefull for other stuff, too.

That's fine. If it proves useful for other things, we can move it. 

> I do not think placing swsusp.h in drivers/power/swsusp is right. It
> should be in include/linux or include/linux/power.

That header is only for the shared functions between 
drivers/power/swsusp/*.c. There's no need to export it to everyone. 

Under the new model, nothing would call swsusp directly. It would call the
model's functions, which would delegate the call to the user-specified
handler for the action.


	-pat

