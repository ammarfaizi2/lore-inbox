Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVBVPOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVBVPOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 10:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVBVPOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 10:14:31 -0500
Received: from mail.65535.com ([194.193.169.194]:60117 "EHLO bigcake.65535.com")
	by vger.kernel.org with ESMTP id S262325AbVBVPO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 10:14:27 -0500
Message-ID: <421B4CE7.7010505@65535.com>
Date: Tue, 22 Feb 2005 15:16:55 +0000
From: "j@65535.com" <j@65535.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041210)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: APM Suspend with savagefb
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If i compile my IBM Thinkpad T23 to use APM and the savagefb driver for 
a framebuffer console, it will hang when resuming from a suspend or 
hibernate. The system is unresponsive, the screen is totally blank and 
no input makes any difference, it is necessary to hard reset the system..
This behavior can be reproduced on 2.6.10-ac10, 2.6.10, and 2.6.11-rc2
When compiling any of these versions without framebuffer support, 
suspend and hibernate work perfectly. It is also not possible for me to 
use ACPI currently as (aside from this problem) the 
suspend/resume/hibernate code is nowhere near as stable.
The videocard is identified as:
   Bus  1, device   0, function  0:
     VGA compatible controller: S3 Inc. SuperSavage IX/C SDR (rev 5).
       IRQ 11.
       Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
       Non-prefetchable 32 bit memory at 0xc0100000 [0xc017ffff].
       Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
       Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
       Prefetchable 32 bit memory at 0xe0000000 [0xe1ffffff].

I'm using kernel commandline "video=savagefb:1024x768@70" to enable the 
savage framebuffer device..

Any ideas on this? Perhaps the savagefb device doesn't correctly 
reinitialize the display on resume? I seem to remember VesaFB worked 
fine with suspend/resume, tho i haven't tested that on the T23 and it 
would definately be preferable to have the actual savage driver.

Regards,
	Bert
