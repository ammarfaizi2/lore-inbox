Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTABOGe>; Thu, 2 Jan 2003 09:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTABOGe>; Thu, 2 Jan 2003 09:06:34 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:29444 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261900AbTABOGd>; Thu, 2 Jan 2003 09:06:33 -0500
Message-ID: <3E143F74.434AD08B@linux-m68k.org>
Date: Thu, 02 Jan 2003 14:32:36 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] top-level config menu dependencies
References: <20030101162519.GF15200@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tomas Szepe wrote:

> While converting the way submenus appear in menuconfig depending on
> their main, parent config option, I stumbled upon certain subsystems
> (such as MTD or IrDA) that should clearly have an on/off switch directly
> in the main menu so that one doesn't have to enter the corresponding
> submenus to even see if they're enabled or disabled.
> 
> Since the new kernel configurator would have no problems with such
> a setup, I'm posting this RFC to get the general opinion on whether
> this should be carried on with.  I'm willing to create and send in
> the patches.

While all config programs should be able to handle this, it might look a
bit strange. Especially the split view of xconfig relies a bit on the
current organisation of the config data.
My idea to handle this would be to turn e.g.:

menu "Memory Technology Devices (MTD)"

config MTD
	tristate "Memory Technology Device (MTD) support"

into something like this:

menuconfig MTD
	tristate "Memory Technology Device (MTD) support"

This would give the front ends the most flexibility. The required
changes are quite small, so it should be doable for 2.6. I'm not
completely sure about the syntax yet, but above is the most likely
version.

bye, Roman


