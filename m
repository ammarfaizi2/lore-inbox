Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278120AbRKNVwo>; Wed, 14 Nov 2001 16:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278085AbRKNVwf>; Wed, 14 Nov 2001 16:52:35 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:29992 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S278042AbRKNVwS>; Wed, 14 Nov 2001 16:52:18 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: TreeWater Society Berlin
To: sensors@stimpy.netroedge.com
Subject: Re: [lm_sensors] hard lockup on modprobe w83781d with Tyan Dual K7/Thunder
Date: Wed, 14 Nov 2001 22:52:13 +0100
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011114180440.A8934A99@shrek.lisa.de>
In-Reply-To: <20011114180440.A8934A99@shrek.lisa.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011114215215.0692E1097@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 14. November 2001 19:04, Hans-Peter Jansen wrote:
> Hello,
>
> I'm trying to get serveral lm_sensor versions up to CVS lm_sensors2 from
> yesterday to run on this mb. Now, I'm at linux-2.4.15-pre4, but also tried
> some 2.4.12(-ac?) versions, to no avail.

I finally managed to get the w83781d loading under 2.4.13-ac7. (b/c it's butt 
kicking processor power)

But it's readings are bogus <BIOS>:
tyrex:~# sensors
w83782d-i2c-0-2d
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.72 V  (min =  +1.74 V, max =  +1.93 V)       ALARM    <1.75>
VCore 2:   +2.83 V  (min =  +1.74 V, max =  +1.93 V)                <1.76>
+3.3V:     +3.32 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +4.89 V  (min =  +4.72 V, max =  +5.24 V)                <5.11>
+12V:      +4.67 V  (min = +10.79 V, max = +13.19 V)                <12.35>
-12V:      -2.01 V  (min = -10.90 V, max = -13.21 V)                <-12.15>
-5V:       +2.71 V  (min =  -4.76 V, max =  -5.26 V)              
V5SB:      +4.32 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +3.29 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:     7180 RPM  (min = 3000 RPM, div = 2)                       <3590>
fan2:     7105 RPM  (min = 3000 RPM, div = 2)                       <3515>
fan3:        0 RPM  (min = 3000 RPM, div = 2)                     
temp1:    +77.0°C   (limit = +60°C, hysteresis = +50°C) sensor = thermistor 
<46°C>          
temp2:    +76.5°C   (limit = +60°C, hysteresis = +50°C) sensor = thermistor   
<41°C>        
temp3:    +77.0°C   (limit = +60°C, hysteresis = +50°C) sensor = thermistor   
<46°C>        
vid:      +1.85 V
alarms:   Chassis intrusion detection                      ALARM  
beep_enable:
          Sound alarm disabled

ALARM flags seems to appear randomly and unrelated to error conditions.
Do I need completely new formula's for that beast?
Any further suggestions?

Cheers,
Hans-Peter
