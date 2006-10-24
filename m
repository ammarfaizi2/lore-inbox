Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWJXKJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWJXKJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 06:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWJXKJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 06:09:24 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:1670 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S965125AbWJXKJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 06:09:23 -0400
Message-ID: <453DE64A.4040507@ruault.com>
Date: Tue, 24 Oct 2006 12:09:14 +0200
From: Charles-Edouard Ruault <ce@ruault.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] PPC suspend to ram broken on 2.6.18.1
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
i'm running Fedora core 5 on my Powerbook G4 laptop, i'm using the 
Fedora provided kernels and since version 2.6.17 i'm unable to have the 
laptop suspend to ram as it used to do before.
I'm unplugging the network cable, the usb mouse and the power cord. Then 
i close the lid. I don't see the blinking led
When i open the lid nothing happens, black screen. The only way out is a 
hard reboot.
Here are the last logs i see in /var/log/messages:

Oct 24 11:37:22 kaluha pmud[2262]: running /etc/power/pwrctl minimum battery
Oct 24 11:37:22 kaluha pwrctl: calling /etc/power/pwrctl-local minimum 
battery
Oct 24 11:37:22 kaluha pwrctl-local: minimum power battery
Oct 24 11:37:30 kaluha kernel: usb 2-1: USB disconnect, address 4
Oct 24 11:37:43 kaluha pmud[2262]: running /etc/power/pwrctl lid-closed 
battery
Oct 24 11:37:43 kaluha pwrctl: calling /etc/power/pwrctl-local 
lid-closed battery
Oct 24 11:37:43 kaluha pwrctl-local: lid-closed battery
Oct 24 11:37:43 kaluha pmud[2262]: lid closed: request sleep
Oct 24 11:37:43 kaluha pmud[2262]: running /etc/power/pwrctl sleep battery
Oct 24 11:37:43 kaluha pwrctl: calling /etc/power/pwrctl-local sleep battery
Oct 24 11:37:43 kaluha pwrctl-local: sleep battery
Oct 24 11:37:43 kaluha pmud[2262]: going to sleep
Oct 24 11:37:45 kaluha kernel:  usbdev3.1_ep81: PM: suspend 0->2, parent 
3-0:1.0 already 1
Oct 24 11:37:45 kaluha kernel:  usbdev2.1_ep81: PM: suspend 0->2, parent 
2-0:1.0 already 1

here's my hardware info:

processor       : 0
cpu             : 7447/7457, altivec supported
clock           : 612.000000MHz
revision        : 0.1 (pvr 8002 0101)
bogomips        : 36.73
timebase        : 18432000
platform        : PowerMac
machine         : PowerBook5,2
motherboard     : PowerBook5,2 MacRISC3 Power Macintosh
detected as     : 287 (PowerBook G4 15")
pmac flags      : 0000001b
L2 cache        : 512K unified
pmac-generation : NewWorld
 
uname -a
Linux kaluha 2.6.18-1.2200.fc5 #1 Sat Oct 14 17:05:22 EDT 2006 ppc ppc 
ppc GNU/Linux

Any help would be greatly appreciated !
Regards.
Please CC me since i do not subscribe to the list.


-- 
Charles-Edouard Ruault
GPG key Id E4D2B80C

