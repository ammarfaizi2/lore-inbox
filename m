Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272386AbVBERKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272386AbVBERKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 12:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272525AbVBERKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 12:10:15 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:43972 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S272386AbVBERKH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 12:10:07 -0500
Message-ID: <4204FDEA.3090306@drzeus.cx>
Date: Sat, 05 Feb 2005 18:10:02 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Strange device init
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problem with a card reader on a laptop (Acer Aspire 1501). 
The device doesn't get its resources configured properly.

The reader is connected to the LPC bus so there is no standardised way 
to configure the device. On other laptops the configuration is done via 
ACPI (_STA & co. in the DSDT). On this laptop these functions don't do a 
damn thing.
In Windows this device gets configured through some other means. It's 
not in the driver (I've disected it to confirm this). But under Linux 
the device is left unconfigured.

So my question is if anyone has any ideas on how this device gets 
configured by Windows and possibly how we can get this to work on Linux.

The reason this is an issue is that one cannot detect all the quirks of 
the hardware so a PNP solution is prefered. In those cases the 
manufacturer has chosen resources that work ok.

For some context: I am the maintainer of the driver for this hardware. I 
have a laptop where the DSDT properly sets up the hardware. The Acer 
belongs to some of my users but they are not familiar with the kernel so 
I'm trying to fix this for them.

Rgds
Pierre

