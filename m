Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267358AbTAGJpf>; Tue, 7 Jan 2003 04:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbTAGJpf>; Tue, 7 Jan 2003 04:45:35 -0500
Received: from [212.71.168.94] ([212.71.168.94]:48371 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S267358AbTAGJpe>; Tue, 7 Jan 2003 04:45:34 -0500
Date: Tue, 7 Jan 2003 10:54:06 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Kaleb Pederson <kibab@icehouse.net>
Cc: Lkml <linux-kernel@vger.kernel.org>
Subject: Re: windows=stable, linux=5 reboots/50 min
Message-ID: <20030107095406.GH2141@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	Kaleb Pederson <kibab@icehouse.net>,
	Lkml <linux-kernel@vger.kernel.org>
References: <LDEEIFJOHNKAPECELHOAKEJFCCAA.kibab@icehouse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LDEEIFJOHNKAPECELHOAKEJFCCAA.kibab@icehouse.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 10:57:03PM -0800, Kaleb Pederson wrote:
> After a recent hard drive crash, I re-installed Linux to a new hard drive.
> After about 2 weeks, my system now spontaneously reboots about once per 10
> minutes (on avg.).  I'm assuming I messed up something in my kernel
> configuration as Windows is still stable. To verify that it wasn't the new
> hard drive (or use of different controller) I formatted a segment of it
> under Windows and copied 7+ gb of data onto it while doing other things
> without problem.
> 
> The system will reboot as early as after detecting the hard drives and
> before loading the root filesystem or anytime thereafter - sometimes in
> logging into the console, sometimes in X.
> 
> My system configuration is as follows:
> 
> Microstar 694D-Pro-AR
> Dual PIII - 800's - not overclocked
> Nice 450 Watt PS
> Onboard Promise PDC20265
> Onboard AC97Audio - Disabled
> Soundblaster Live
> 2 Hard drives
>  - 1=IBM-40gb on Promise Controller
>  - 1=WD-80gb on onboard UDMA/66 controller (previous configuration was also
> on promise)
> USB Keyboard/Mouse/Scanner
> Intel EEPro100
> NVidia TNT2 Utlra (considering the system sometimes crashes before I enter X
> and before the NVidia driver is loaded, my kernel has not been tainted at
> this point).
> 
> I don't get any messages is /var/log/... nor do I get an oops.  I have tried
> this under 2.4.19, 2.4.20, and 2.4.21-pre2 (all compiled with gcc-2.95.3)
> and I get the same behavior.  I have noticed no similarities between the
> crashes.  At this point, I have no idea how to isolate it other than to
> start removing every single unnecessary kernel module/option from my .config
> and recompiling.  Any suggestions?  Want to see a grep of my .config?

I have just replaced a power-source (the new one has higher power) and
the machine started crashing.  Until I increased voltages for CPU in
bios. Maybe playing with bios in ways like changing core and IO voltage,
changing various timings etc. could help. You could also try disabling
the SCSI and IDE controlers in turn if one of them - or the linux driver
for one of them - is to blame.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
