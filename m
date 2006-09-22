Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWIVJKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWIVJKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWIVJKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:10:11 -0400
Received: from ku-gbr.de ([81.3.11.18]:37522 "EHLO ku-gbr.de")
	by vger.kernel.org with ESMTP id S1750815AbWIVJKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:10:10 -0400
Date: Fri, 22 Sep 2006 11:10:50 +0200
From: Konstantin Kletschke <lists@ku-gbr.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060922091049.GA5218@anita.doom>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org> <20060904223153.GK13238@bayes.mathematik.tu-chemnitz.de> <200609042017.03515.gene.heskett@verizon.net> <200609051704.41576.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609051704.41576.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2006-09-05 17:04 +0100 schrieb Alistair John Strachan:

> Might not be a kernel problem, userspace might be using libusb and calling 
> usb_reset() on the device. Try dropping out of X11 and see if it still 
> happens.


I have this with 18_rc6 and 18_rc7 also:

Sep 22 11:01:50 anita usb 1-3: reset low speed USB device using ohci_hcd
and address 3
Sep 22 11:03:17 anita usb 1-3: reset low speed USB device using ohci_hcd
and address 3
Sep 22 11:04:04 anita usb 1-3: reset low speed USB device using ohci_hcd
and address 3
Sep 22 11:04:52 anita usb 1-3: reset low speed USB device using ohci_hcd
and address 3
Sep 22 11:05:46 anita usb 1-3: reset low speed USB device using ohci_hcd
and address 3
Sep 22 11:06:30 anita usb 1-3: reset low speed USB device using ohci_hcd
and address 3

In older Kernels or even 2.6.17 I never saw this.
So may be the initial report was barking at the wrong tree, this is a
plugged wired USB keyboard (daskeyboard.com).
The Keyboard is fully functional while typing on it and this happens
without being in X. It happens with nobody logged in local, the messages
are logged even only when logged in via ssh.

libusb and usbutils are not installed on this machine (should they?).

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  3 Spd=1.5 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046a ProdID=0048 Rev= 0.26
S:  Product=Das Keyboard
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms


Regards, Konsti



-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
