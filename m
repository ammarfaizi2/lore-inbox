Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWJMOiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWJMOiO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWJMOiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:38:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:59725 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1750928AbWJMOiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:38:13 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,307,1157353200"; 
   d="scan'208"; a="3544041:sNHT26490213"
Message-ID: <452FA451.6090702@intel.com>
Date: Fri, 13 Oct 2006 07:36:01 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org,
       magnus.damm@gmail.com, pavel@suse.cz
Subject: Re: Machine reboot
References: <20061013000556.89570.qmail@web83108.mail.mud.yahoo.com> <452F1142.3000400@intel.com> <20061013091608.GH18163@mail.muni.cz>
In-Reply-To: <20061013091608.GH18163@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2006 14:38:11.0054 (UTC) FILETIME=[34F4C8E0:01C6EED5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
> On Thu, Oct 12, 2006 at 09:08:34PM -0700, Auke Kok wrote:
>>> and this device is Gb ethernet, e1000 is perfect candidate to look at. And 
>>> yes, removing e1000
>>> before reboot works around the issue.
>> Have you tried to only `ifconfig ethX down` ? my own i965 board shuts down 
>> perfectly fine without unloading the e1000 driver.
> 
> I can confirm that rmmod e1000 causes that machine can reboot gracefully.
> 
>> Would you be able to debug a failed shutdown perhaps and capture the 
>> console output? when exactly does it `stall` ? What other interrupts are 
>> assigned on your system? Did other BIOS versions work correctly?
> 
> Up to version 0864 it restarts normally. Any higher version causes hang on
> restart if e1000 driver is loaded.
> 
> I've tried to report it to Intel but they replied that Linux is unsupported on
> this board...
> 
> It's not an issue in the Linux kernel. Using various printk I can see that
> tripple fault or reset via KBD is issued and followed by hang of the BIOS. 
> 
> For i965 chipsets, the BIOS is *a lot* buggy :(

that's depressing, can you send me the output of `dmidecode` of the latest BIOS? Perhaps 
I can reproduce it myself with that version.

Auke
