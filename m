Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVCCW6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVCCW6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVCCWyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:54:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:5599 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262661AbVCCWvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:51:53 -0500
Subject: Re: radeonfb blanks my monitor
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= "L. W. Meunier" <2@pervalidus.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0503031149280.311@darkstar.example.net>
References: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net>
	 <1109823010.5610.161.camel@gaston>
	 <Pine.LNX.4.62.0503030134200.311@darkstar.example.net>
	 <1109825452.5611.163.camel@gaston>
	 <Pine.LNX.4.62.0503031149280.311@darkstar.example.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 04 Mar 2005 09:48:57 +1100
Message-Id: <1109890137.5610.233.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 12:38 -0300, Frédéric L. W. Meunier wrote:
> On Thu, 3 Mar 2005, Benjamin Herrenschmidt wrote:
> 
> > There should be more than these... Does it continue booting 
> > afte the screen goes blank or not at all ? Can you send the 
> > full dmesg log too ? Also, enable radeonfb verbose debug in 
> > the config.
> 
> Yes, there were more in /var/log/syslog:
> 
> Mar  2 15:16:45 darkstar kernel: radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=325.00 Mhz, System=200.00 MHz
> Mar  2 15:16:45 darkstar kernel: radeonfb: PLL min 20000 max 40000
> Mar  2 15:16:45 darkstar kernel: i2c-algo-bit.o: monid seems to be busy.
> Mar  2 15:16:45 darkstar kernel: radeonfb 0000:01:00.0: Failed to register I2C bus monid.
> Mar  2 15:16:45 darkstar kernel: i2c-algo-bit.o: crt2 seems to be busy.
> Mar  2 15:16:46 darkstar kernel: radeonfb 0000:01:00.0: Failed to register I2C bus crt2.
> Mar  2 15:16:46 darkstar kernel: Console: switching to colour frame buffer device 90x25
> Mar  2 15:16:46 darkstar kernel: radeonfb (0000:01:00.0): ATI Radeon AP
> 
> Do the "seems to be busy." and/or "Failed to register I2C bus" 
> indicate a problem ?

Maybe we are having conflicting bus names between radeonfb and matroxfb,
or 2 instances of radeonfb ? Can you send the entire log please ?

> There's nothing about radeonfb in dmesg because I manually 
> loaded the modules.

And ? You should have it in dmesg after the module load...

> I now compiled built-in with debug enabled and got the same 
> problem. Nothing got logged. Everything seems to stop when it 
> blanks, but SysRq works.


Well, I would need the full log, and with radeonfb verbose debug enabled
in the config.

Ben.


