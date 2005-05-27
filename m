Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVE0CQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVE0CQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 22:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVE0CQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 22:16:34 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:62614 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261414AbVE0CQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 22:16:32 -0400
Message-ID: <42968306.9060609@m1k.net>
Date: Thu, 26 May 2005 22:16:38 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-mm1 breaks serio: i8042 AUX port
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.12-rc5-mm1, I can't use my psaux mouse, but it worked perfectly 
fine in both 2.6.12-rc5 and in 2.6.12-rc4-mm2.

In 2.6.12-rc5-mm1 , dmesg says:

PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Failed to disable AUX port, but continuing anyway... Is this a SiS?
If AUX port is really absent please use the 'i8042.noaux' option.
serio: i8042 KBD port at 0x60,0x64 irq 1

This is what dmesg says in both 2.6.12-rc4-mm2 and 2.6.12-rc5 :

PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1

I am using a Shuttle FT61 motherboard.  Is there any more information 
necessary to debug this?
