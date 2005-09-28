Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVI1J1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVI1J1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVI1J1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:27:12 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:50563 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1750813AbVI1J1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:27:10 -0400
Message-ID: <433A617F.3020507@cs.aau.dk>
Date: Wed, 28 Sep 2005 11:25:19 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
References: <20050927093929.83645.qmail@web51010.mail.yahoo.com>
In-Reply-To: <20050927093929.83645.qmail@web51010.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Actually this autoconfig thing raise quite a lot of questions to me.

1) What should be detected, what should not ?

It seems obvious that all the choices beyond hardware are choices that
the user should do (what network protocols, what kind of filesystems,
etc). But, as Boddo Eggert pointed out (if I understood well), all the
hardware which is lying outside of the box (printer, scanner, usb key,
...) could be detected if plugged when the autoconfig is ran.

Should we trust these informations (as theses devices can be removed at
any time) ? Shouldn't we let the user make these choices by himself ?
What is the limit of the devices we can assume to be part of the machine
when building this autoconfig ?

2) What is the surest and the most stable way to detect the hardware ?

lspci, lsusb, dmidecode (or /proc and /sys) have been mentioned. This
brings two sub-questions:
- What kind of software environment / kernel release can we assume ?
- How to minimize the dependencies of the detection from other tools ?
 (changing all the Kconfigs just because the syntax of the output of one
of these command has changed would be quite painful).


3) Can this hardware detection be included in other interfaces ?

It would be nice to have this detection to be ran when no pre existing
.config is detected in all other interfaces (menuconfig, config, ...).


Regards
-- 
Emmanuel Fleury

Discontent is the first step in the progress of a man or a nation.
  -- Oscar Wilde
