Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbVCDRVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVCDRVC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVCDRS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:18:26 -0500
Received: from 200-170-96-180.veloxmail.com.br ([200.170.96.180]:1397 "HELO
	qmail-out.veloxmail.com.br") by vger.kernel.org with SMTP
	id S262930AbVCDROm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:14:42 -0500
X-qfilter-stat: ok
Date: Fri, 4 Mar 2005 14:14:37 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb blanks my monitor
In-Reply-To: <Pine.LNX.4.62.0503032044350.416@darkstar.example.net>
Message-ID: <Pine.LNX.4.62.0503041407230.163@darkstar.example.net>
References: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net>  <1109823010.5610.161.camel@gaston> 
	<Pine.LNX.4.62.0503030134200.311@darkstar.example.net>  <1109825452.5611.163.camel@gaston> 
	<Pine.LNX.4.62.0503031149280.311@darkstar.example.net> <1109890137.5610.233.camel@gaston>
	<Pine.LNX.4.62.0503032044350.416@darkstar.example.net>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-341110897-1109956477=:163"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-341110897-1109956477=:163
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 3 Mar 2005, Fr=E9d=E9ric L. W. Meunier wrote:

> On Fri, 4 Mar 2005, Benjamin Herrenschmidt wrote:
>
>>  Well, I would need the full log, and with radeonfb verbose debug enable=
d=20
>>  in the config.
>
> I'll later try as module with debug.

Here's:

/var/log/messages:

Mar  4 14:00:29 pervalidus kernel: radeonfb: Found Intel x86 BIOS ROM Image
Mar  4 14:00:29 pervalidus kernel: radeonfb: Retreived PLL infos from BIOS
Mar  4 14:00:30 pervalidus kernel: radeonfb: Monitor 1 type CRT found
Mar  4 14:00:30 pervalidus kernel: radeonfb: EDID probed
Mar  4 14:00:30 pervalidus kernel: radeonfb: Monitor 2 type no found

/var/log/syslog:

Mar  4 14:00:28 pervalidus kernel: radeonfb_pci_register BEGIN
Mar  4 14:00:28 pervalidus kernel: radeonfb (0000:01:00.0): Found 262144k o=
f DDR 128 bits wide videoram
Mar  4 14:00:29 pervalidus kernel: radeonfb (0000:01:00.0): mapped 16384k v=
ideoram
Mar  4 14:00:29 pervalidus kernel: radeonfb: Reference=3D27.00 MHz (RefDiv=
=3D12) Memory=3D325.00 Mhz, System=3D200.00 MHz
Mar  4 14:00:29 pervalidus kernel: radeonfb: PLL min 20000 max 40000
Mar  4 14:00:29 pervalidus kernel: 1 chips in connector info
Mar  4 14:00:29 pervalidus kernel:  - chip 1 has 2 connectors
Mar  4 14:00:29 pervalidus kernel:   * connector 0 of type 2 (CRT) : 2300
Mar  4 14:00:29 pervalidus kernel:   * connector 1 of type 3 (DVI-I) : 3221
Mar  4 14:00:29 pervalidus kernel: Starting monitor auto detection...
Mar  4 14:00:29 pervalidus kernel: radeonfb: I2C (port 1) ... not found
Mar  4 14:00:29 pervalidus kernel: radeonfb: I2C (port 2) ... not found
Mar  4 14:00:29 pervalidus kernel: radeonfb: I2C (port 3) ... found CRT dis=
play
Mar  4 14:00:30 pervalidus kernel: radeonfb: I2C (port 4) ... not found
Mar  4 14:00:30 pervalidus kernel: radeonfb: I2C (port 2) ... not found
Mar  4 14:00:30 pervalidus kernel: radeonfb: I2C (port 4) ... not found
Mar  4 14:00:30 pervalidus kernel: radeonfb: I2C (port 3) ... found CRT dis=
play
Mar  4 14:00:30 pervalidus kernel: hStart =3D 694, hEnd =3D 757, hTotal =3D=
 795
Mar  4 14:00:30 pervalidus kernel: vStart =3D 402, vEnd =3D 408, vTotal =3D=
 418
Mar  4 14:00:30 pervalidus kernel: h_total_disp =3D 0x590062^I   hsync_strt=
_wid =3D0x8702c0
Mar  4 14:00:30 pervalidus kernel: v_total_disp =3D 0x18f01a1^I   vsync_str=
t_wid =3D 0x860191
Mar  4 14:00:30 pervalidus kernel: pixclock =3D 85925
Mar  4 14:00:30 pervalidus kernel: freq =3D 1163
Mar  4 14:00:30 pervalidus kernel: freq =3D 1666, PLL min =3D 20000, PLL ma=
x =3D 40000
Mar  4 14:00:30 pervalidus kernel: ref_div =3D 12, ref_clk =3D 2700, output=
_freq =3D 26656
Mar  4 14:00:30 pervalidus kernel: ref_div =3D 12, ref_clk =3D 2700, output=
_freq =3D 26656
Mar  4 14:00:30 pervalidus kernel: post div =3D 0x5
Mar  4 14:00:30 pervalidus kernel: fb_div =3D 0x76
Mar  4 14:00:30 pervalidus kernel: ppll_div_3 =3D 0x50076
Mar  4 14:00:30 pervalidus kernel: Console: switching to colour frame buffe=
r device 90x25
Mar  4 14:00:30 pervalidus kernel: radeonfb (0000:01:00.0): ATI Radeon AP
Mar  4 14:00:30 pervalidus kernel: radeonfb_pci_register END

BTW, I noticed that it locking the system. I was able to issue=20
a shutdown. The commands still work, but beep is disabled.

--=20
How to contact me - http://www.pervalidus.net/contact.html

--8323328-341110897-1109956477=:163--
