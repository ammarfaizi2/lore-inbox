Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVENR17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVENR17 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 13:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVENR17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 13:27:59 -0400
Received: from animx.eu.org ([216.98.75.249]:36502 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262807AbVENR15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 13:27:57 -0400
Date: Sat, 14 May 2005 13:26:19 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux@dominikbrodowski.net
Subject: Re: [PATCH] pcmcia/ds: handle any error code
Message-ID: <20050514172619.GA5835@animx.eu.org>
Mail-Followup-To: randy_dunlap <rdunlap@xenotime.net>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	linux@dominikbrodowski.net
References: <20050512015220.GA31634@animx.eu.org> <20050512230206.GA1380@animx.eu.org> <20050512222038.325081b2.rdunlap@xenotime.net> <20050513194549.GB3519@animx.eu.org> <20050514102213.3440c526.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050514102213.3440c526.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:
> On Fri, 13 May 2005 15:45:49 -0400 Wakko Warner wrote:
> | I just tried it, it doesn't give me any errors.  This is strange considering
> | that I a) use a pristine tree for each kernel (only coping the .config) and
> | b) the patch doesn't do anything except report the error.  I made my boot
> | floppy (the scripts I use pull from the kernel tree I specify and make the
> | image I need) and booted from it.  I placed the modules on my stage2 disk
> | that was made and it works.
> | 
> | I don't have the time this week to try again from scratch.  I'll see if I
> | can do it next week.
> 
> I'm currently running a kernel built with -Os.  I can successfully
> load pcmcia_core.ko and pcmcia.ko.  I added debug printk's in
> drivers/pcmcia/ds.c and it allocates the dynamic major dev
> successfully:

I noticed this too.  I can't figure out why it wasn't working before.  I
don't believe the method of loading the kernel (hdd, usb, floppy) would
cause this.  Next week when I get a chance to work more on this project,
I'll wipe out my entire kernel tree (saving the .config) and try again (I
keep pristine sources in /usr/src/linux/dist/<kernel vers>)

> What gcc version are you using?  (gcc 4.0 has a few known issues.)

gcc (GCC) 3.4.4 20050314 (prerelease) (Debian 3.4.3-12)

I have gcc-3.3 also installed.  Should I use it instead?

I follow the list somewhat (only interesting sujects =) and I have noticed
that 4.0 has some problems.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
