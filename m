Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbTAFWs3>; Mon, 6 Jan 2003 17:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbTAFWs3>; Mon, 6 Jan 2003 17:48:29 -0500
Received: from mail.icehouse.net ([204.203.53.2]:38148 "HELO mail.icehouse.net")
	by vger.kernel.org with SMTP id <S267173AbTAFWs1>;
	Mon, 6 Jan 2003 17:48:27 -0500
From: "Kaleb Pederson" <kibab@icehouse.net>
To: "Lkml" <linux-kernel@vger.kernel.org>
Subject: windows=stable, linux=5 reboots/50 min
Date: Mon, 6 Jan 2003 22:57:03 -0800
Message-ID: <LDEEIFJOHNKAPECELHOAKEJFCCAA.kibab@icehouse.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a recent hard drive crash, I re-installed Linux to a new hard drive.
After about 2 weeks, my system now spontaneously reboots about once per 10
minutes (on avg.).  I'm assuming I messed up something in my kernel
configuration as Windows is still stable. To verify that it wasn't the new
hard drive (or use of different controller) I formatted a segment of it
under Windows and copied 7+ gb of data onto it while doing other things
without problem.

The system will reboot as early as after detecting the hard drives and
before loading the root filesystem or anytime thereafter - sometimes in
logging into the console, sometimes in X.

My system configuration is as follows:

Microstar 694D-Pro-AR
Dual PIII - 800's - not overclocked
Nice 450 Watt PS
Onboard Promise PDC20265
Onboard AC97Audio - Disabled
Soundblaster Live
2 Hard drives
 - 1=IBM-40gb on Promise Controller
 - 1=WD-80gb on onboard UDMA/66 controller (previous configuration was also
on promise)
USB Keyboard/Mouse/Scanner
Intel EEPro100
NVidia TNT2 Utlra (considering the system sometimes crashes before I enter X
and before the NVidia driver is loaded, my kernel has not been tainted at
this point).

I don't get any messages is /var/log/... nor do I get an oops.  I have tried
this under 2.4.19, 2.4.20, and 2.4.21-pre2 (all compiled with gcc-2.95.3)
and I get the same behavior.  I have noticed no similarities between the
crashes.  At this point, I have no idea how to isolate it other than to
start removing every single unnecessary kernel module/option from my .config
and recompiling.  Any suggestions?  Want to see a grep of my .config?

TIA,

--Kaleb
PS: Although I'm going to try to monitor the list for the next few days,
please CC me in case I miss it.

