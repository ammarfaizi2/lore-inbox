Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbTDGUbc (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbTDGUbb (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:31:31 -0400
Received: from www.wotug.org ([194.106.52.201]:25469 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id S263648AbTDGUba (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 16:31:30 -0400
Message-Id: <5.2.0.9.0.20030407213727.0207ddf8@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 07 Apr 2003 21:43:03 +0100
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: Problems booting PDC20276 with new IDE setup code.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E918B13.4080805@gmx.net>
References: <5.2.0.9.0.20030407141330.00b346c0@mailhost.ivimey.org>
 <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org>
 <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org>
 <5.2.0.9.0.20030407141330.00b346c0@mailhost.ivimey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:28 07/04/2003, Carl-Daniel Hailfinger wrote:
>Ruth Ivimey-Cook wrote:
>>At 03:34 07/04/2003, Carl-Daniel Hailfinger wrote:
>>>Could you please try 2.4.21-pre7 (this has another batch of IDE updates) 
>>>and enable the option
>>>"Special FastTrak Feature"?
>>>In your .config, the option would be
>>>CONFIG_PDC202XX_FORCE=y
>>>and report back to the list?
>>For reasons reported in another mail (ac97 fails to build) my attempt at 
>>pre7 failed. Also, as far as I know, the FastTrak feature enables the 
>>Promise RAID mode: I am not using that. Instead, I just want 4 IDE disks 
>>which will be bound using Linux raid5.
>No, without the "Special FastTrak Feature" you cannot see the disks at 
>all, regardless if you want RAID or plain IDE.

I constructed a -pre7 kernel without sound support to get over the other 
issue, and enabled the Special Feature. The disks were recognised as ide2 
and ide3 and init started ok. Sadly, another issue prevented the machine 
from booting fully, so I am not sure if all is well. I will pursue things 
further shortly.

I don't understand, though, why in 2.4.20 we had 2 modes -- non-Special to 
get IDE-only and Special to get FastTrak RAID support, and now we only have 
one, with the non-Special setting being a no-op and, apparently, Special 
being IDE only.

What is happening?

Ruth 

