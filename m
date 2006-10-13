Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWJMJQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWJMJQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 05:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWJMJQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 05:16:17 -0400
Received: from tirith2.ics.muni.cz ([147.251.4.39]:9653 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750781AbWJMJQQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 05:16:16 -0400
Date: Fri, 13 Oct 2006 11:16:08 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org,
       magnus.damm@gmail.com, pavel@suse.cz
Subject: Re: Machine reboot
Message-ID: <20061013091608.GH18163@mail.muni.cz>
References: <20061013000556.89570.qmail@web83108.mail.mud.yahoo.com> <452F1142.3000400@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <452F1142.3000400@intel.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Muni-Spam-TestIP: 81.31.45.161
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 09:08:34PM -0700, Auke Kok wrote:
> >and this device is Gb ethernet, e1000 is perfect candidate to look at. And 
> >yes, removing e1000
> >before reboot works around the issue.
> 
> Have you tried to only `ifconfig ethX down` ? my own i965 board shuts down 
> perfectly fine without unloading the e1000 driver.

I can confirm that rmmod e1000 causes that machine can reboot gracefully.

> Would you be able to debug a failed shutdown perhaps and capture the 
> console output? when exactly does it `stall` ? What other interrupts are 
> assigned on your system? Did other BIOS versions work correctly?

Up to version 0864 it restarts normally. Any higher version causes hang on
restart if e1000 driver is loaded.

I've tried to report it to Intel but they replied that Linux is unsupported on
this board...

It's not an issue in the Linux kernel. Using various printk I can see that
tripple fault or reset via KBD is issued and followed by hang of the BIOS. 

For i965 chipsets, the BIOS is *a lot* buggy :(

-- 
Luká¹ Hejtmánek
