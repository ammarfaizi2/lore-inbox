Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWAEA47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWAEA47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWAEA46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:56:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52191 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751025AbWAEA4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:56:33 -0500
Date: Thu, 5 Jan 2006 01:55:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface (rev. 2)
Message-ID: <20060105005559.GC1751@elf.ucw.cz>
References: <200601042340.42118.rjw@sisk.pl> <200601042351.58667.rjw@sisk.pl> <20060104234918.GA15983@kroah.com> <20060105001837.GA1751@elf.ucw.cz> <20060105002619.GA16714@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105002619.GA16714@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Unless you want to turn these into syscalls :)
> > 
> > Well, I think we simply want to get static major/minor allocated for
> > this device. It really uses read/write, IIRC, so no, I do not think we
> > want to make it a syscall.
> 
> Ok, then I'd recommend using the misc device, dynamic for now, and
> reserve one when you get a bit closer to merging into mainline.

Actually, misc major (character, major 10) seems to be okay,
too. There's stuff like /dev/fuse there, already. But it feels little
crowded there, and /dev/snapshot seems to fit between memory devices
nicely...
								Pavel
-- 
Thanks, Sharp!
