Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSFQIYI>; Mon, 17 Jun 2002 04:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316844AbSFQIYH>; Mon, 17 Jun 2002 04:24:07 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:45214 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S316840AbSFQIYH>; Mon, 17 Jun 2002 04:24:07 -0400
Date: Mon, 17 Jun 2002 10:24:03 +0200
Message-Id: <200206170824.g5H8O3X25927@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: Soewono Effendi <seffendi@web.de>
To: linux-kernel@vger.kernel.org
Subject: [off topic - RFC] APM suspend + hdparam
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there, 
 
I've been playing around with hdparam. 
 
With one of these parameter, one can enjoy the __silence__ stolen by his/her  
beloved computer :( 
 -y   put IDE drive in standby mode 
 -Y   put IDE drive to sleep 
e.g. 
hdparm -Y /dev/hda  
(assume you have only one hard disk, and your linux is there) 
 
But... 
As soon as the kernel accesses the hard disk (bflush? kswapd? etc.), gone is  
the __silence__ :( 
 
So I tried this: 
apm -s & hdparm -Y /dev/hda & 
 
sometime it works, sometime not. I know that "software suspend" is on the  
way, but till denn, this might be easier to "fix". 
 
 
Idea: 
        One can __FREEZE__ the kernel, put IDE drive to sleep and then __sus 
pend__ the system, just like "apm -s" does. 
        If the system wakes up again, waits till IDE is waken up (or maybe le 
ts the kernel wakes it up), and just continue to work as normal, stealin 
g your __silence__ again. 
 
Requirement: 
        APM must work ;).  
        ACPI never tested before. 
 
Purpose: 
        To have ONE BIG BUTTON(TM) that give you a break!  
        and just like magic, on an instant your are back on work again!  
        If you lose your power during this suspend,  
        then may the penguin be with you ;) 
 
I would like to call this feature HOT SUSPEND(TM) :) 
 
Best regards, 
Soewono Effendi 
 
 
DISCLAIMER: 
        I take no responsibilities in any case of data and/or hardware lost 
        if you try these experiments :) 
----------------- 
SEffendi(a)web.de 
================= 
______________________________________________________________________________
FreeMail in der Premiumversion! Mit mehr Speicher, mehr Leistung, mehr 
Erlebnis und mehr Pramie. Jetzt unter http://club.web.de/?mc=021105

