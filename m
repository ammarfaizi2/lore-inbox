Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVCCPiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVCCPiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 10:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVCCPiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 10:38:54 -0500
Received: from 200-170-96-180.veloxmail.com.br ([200.170.96.180]:20684 "EHLO
	200-170-96-186.veloxmail.com.br") by vger.kernel.org with ESMTP
	id S261813AbVCCPiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 10:38:52 -0500
X-Authenticated-User: fredlwm@veloxmail.com.br
X-Authenticated-User: fredlwm@veloxmail.com.br
Date: Thu, 3 Mar 2005 12:38:51 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb blanks my monitor
In-Reply-To: <1109825452.5611.163.camel@gaston>
Message-ID: <Pine.LNX.4.62.0503031149280.311@darkstar.example.net>
References: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net> 
 <1109823010.5610.161.camel@gaston>  <Pine.LNX.4.62.0503030134200.311@darkstar.example.net>
 <1109825452.5611.163.camel@gaston>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Benjamin Herrenschmidt wrote:

> There should be more than these... Does it continue booting 
> afte the screen goes blank or not at all ? Can you send the 
> full dmesg log too ? Also, enable radeonfb verbose debug in 
> the config.

Yes, there were more in /var/log/syslog:

Mar  2 15:16:45 darkstar kernel: radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=325.00 Mhz, System=200.00 MHz
Mar  2 15:16:45 darkstar kernel: radeonfb: PLL min 20000 max 40000
Mar  2 15:16:45 darkstar kernel: i2c-algo-bit.o: monid seems to be busy.
Mar  2 15:16:45 darkstar kernel: radeonfb 0000:01:00.0: Failed to register I2C bus monid.
Mar  2 15:16:45 darkstar kernel: i2c-algo-bit.o: crt2 seems to be busy.
Mar  2 15:16:46 darkstar kernel: radeonfb 0000:01:00.0: Failed to register I2C bus crt2.
Mar  2 15:16:46 darkstar kernel: Console: switching to colour frame buffer device 90x25
Mar  2 15:16:46 darkstar kernel: radeonfb (0000:01:00.0): ATI Radeon AP

Do the "seems to be busy." and/or "Failed to register I2C bus" 
indicate a problem ?

There's nothing about radeonfb in dmesg because I manually 
loaded the modules.

I now compiled built-in with debug enabled and got the same 
problem. Nothing got logged. Everything seems to stop when it 
blanks, but SysRq works.

-- 
How to contact me - http://www.pervalidus.net/contact.html
