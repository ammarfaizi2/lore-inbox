Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279548AbRJXMcU>; Wed, 24 Oct 2001 08:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279551AbRJXMcL>; Wed, 24 Oct 2001 08:32:11 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:50866 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S279548AbRJXMcB>; Wed, 24 Oct 2001 08:32:01 -0400
Posted-Date: Wed, 24 Oct 2001 14:25:04 +0100 (WEST)
Date: Wed, 24 Oct 2001 14:38:36 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200110241238.OAA02419@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.12-ac, lm-sensors broken ??
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I use the lm-sensors on my system, it works fine with 2.2.20pre and 2.4.13 but
not with the ac tree, is there any reason for that ? I compile the i2c and
lm-sensors package as modules outside the kernel. The .config are the same for
both the kernels. The various modules (w83781d i2c-proc i2c-isa i2c-core) loads
fine with both systems.

with 2.4.12-ac5
---------------
[jean-luc@debian-f5ibh] ~ # uname -a
Linux debian-f5ibh 2.4.12-ac5 #1 lun oct 22 12:18:52 CEST 2001 i586 unknown

[jean-luc@debian-f5ibh] ~ # sensors
No sensors found!


system data :

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux debian-f5ibh 2.4.12-ac5 #1 lun oct 22 12:18:52 CEST 2001 i586 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.27
util-linux             2.11l
modutils               2.4.10
e2fsprogs              tune2fs
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         usb-ohci usbcore nfsd lockd sunrpc serial parport_pc lp parport autofs4 es1371 soundcore ac97_codec gameport w83781d i2c-proc i2c-isa i2c-core rtc unix

with 2.4.13
-----------
[jean-luc@debian-f5ibh] ~ # uname -a
Linux debian-f5ibh 2.4.13 #1 mer oct 24 13:22:17 CEST 2001 i586 unknown

[jean-luc@debian-f5ibh] ~ # sensors
w83781d-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
Vcore 1:   +2.24 V  (min =  +2.09 V, max =  +2.30 V)              
Vcore 2:   +2.24 V  (min =  +2.09 V, max =  +2.30 V)              
+3.5V:     +3.52 V  (min =  +3.32 V, max =  +3.66 V)              
+5V:       +4.86 V  (min =  +4.72 V, max =  +5.24 V)              
+12V:     +12.08 V  (min = +11.36 V, max = +12.58 V)              
-12V:     -11.82 V  (min = -11.33 V, max = -12.55 V)              
-5V:       -5.19 V  (min =  -4.74 V, max =  -5.24 V)              
CPU fan:  5400 RPM  (min = 3000 RPM, div = 2)                     
MB:       +39.0°C   (limit = +55°C, hysteresis = +55°C)        
Processor:+46.8°C   (limit = +65°C, hysteresis = +65°C)        
vid:      +3.50 V
alarms:   Chassis intrusion detection                             
beep_enable:
          Sound alarm disabled

system data :

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux debian-f5ibh 2.4.13 #1 mer oct 24 13:22:17 CEST 2001 i586 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.27
util-linux             2.11l
modutils               2.4.10
e2fsprogs              tune2fs
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         usb-ohci usbcore nfsd lockd sunrpc serial parport_pc lp parport autofs4 es1371 soundcore ac97_codec gameport w83781d i2c-proc i2c-isa i2c-core rtc unix

--- 
Regards
		Jean-Luc
