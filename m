Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263040AbSJBLOw>; Wed, 2 Oct 2002 07:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263045AbSJBLOw>; Wed, 2 Oct 2002 07:14:52 -0400
Received: from pop.gmx.de ([213.165.64.20]:23336 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263040AbSJBLOv>;
	Wed, 2 Oct 2002 07:14:51 -0400
Date: Wed, 2 Oct 2002 13:19:47 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: CPU Core voltage
Message-Id: <20021002131947.7c251a39.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry this mail is not directly kernel related but there are the most intelligent people.

I have some trouble with my dual box. Under high load the box crashes or has segfaults. I found out that the problem is cpu related. Cooling the cpu's with 5 fans lets the box be more or less stable!!

Today I found some interesting data:

sensors (from the lm_sensors package) gives me the following output:

root@hdg /home/hdg # sensors
as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.68 V  (min =  +4.08 V, max =  +4.08 V)
VCore 2:   +1.90 V  (min =  +4.08 V, max =  +4.08 V)
           ^^^^^^^
+3.3V:     +3.34 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +4.94 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +12.16 V  (min = +10.79 V, max = +13.11 V)
-12V:      -1.63 V  (min = -15.06 V, max = -12.32 V)
-5V:       -1.26 V  (min =  -5.48 V, max =  -4.50 V)
fan1:     4115 RPM  (min = 1500 RPM, div = 4)
fan2:     4440 RPM  (min = 1500 RPM, div = 4)
fan3:     4218 RPM  (min = 1500 RPM, div = 4)
temp1:       +34°C  (limit =  +60°C)
temp2:     +36.7°C  (limit =  +67°C, hysteresis =  +60°C)
temp3:     +18.7°C  (limit =  +60°C, hysteresis =  +50°C)
vid:      +1.650 V
alarms:
beep_enable:
          Sound alarm enabled

Notice the VCore 2 voltage! 

The installed cpu's are intel pIII Slot1 @ 600Mhz and have a core voltage of 1.70 V. The VCore 1 value seems to be right!

When I show the values in the system-bios it shows me only one core voltage (I don't know which cpu). And it says also 1.7 V.

And now to my question:

Does anybody know the pins of Vcore and gnd from the Slot1 specs so that I can take a measuring instrument and measure the core voltage?

Unfortunately I can't switch the core voltage in the system bios:-(

Thank you for the help

Marc Giger
