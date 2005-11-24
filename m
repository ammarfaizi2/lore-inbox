Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbVKXGO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbVKXGO7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 01:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbVKXGO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 01:14:59 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:17677 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1161011AbVKXGO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 01:14:58 -0500
Message-ID: <43855A50.80808@tuxrocks.com>
Date: Wed, 23 Nov 2005 23:14:40 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Andrew Morton <akpm@osdl.org>, Marc Koschewski <marc@osknowledge.org>,
       linux-kernel@vger.kernel.org, Harald Welte <laforge@netfilter.org>,
       netdev@vger.kernel.org
Subject: Re: Mouse issues in -mm
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123113854.07fca702.akpm@osdl.org> <4385202E.70404@tuxrocks.com> <200511232226.44459.dtor_core@ameritech.net>
In-Reply-To: <200511232226.44459.dtor_core@ameritech.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
> What kind of touchpad do you have? Could you post your
> /pros/bus/input/devices please?

AlpsPS/2 ALPS GlidePoint

/proc/bus/input/devices:
I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
S: Sysfs=/class/input/input0
H: Handlers=kbd event0
B: EV=40001
B: SND=46

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/class/input/input1
H: Handlers=kbd event1
B: EV=120013
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7

I: Bus=0011 Vendor=0002 Product=0008 Version=0000
N: Name="PS/2 Mouse"
P: Phys=isa0060/serio1/input1
S: Sysfs=/class/input/input2
H: Handlers=mouse0 event2
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

I: Bus=0011 Vendor=0002 Product=0008 Version=7321
N: Name="AlpsPS/2 ALPS GlidePoint"
P: Phys=isa0060/serio1/input0
S: Sysfs=/class/input/input3
H: Handlers=mouse1 event3
B: EV=f
B: KEY=420 0 70000 0 0 0 0 0 0 0 0
B: REL=3
B: ABS=1000003


Note: I believe this issue may also be related to the mouse protocol
extension.  I typically run with 'psmouse.proto=exps' on the kernel
command line, and the psmouse resync patch seems to break tapping in
that mode.  However, booting without proto=exps seems to continue to
work, even with the resync patch (though the touchpad is unusably
sensitive--hence the use of exps in the first place).

Thanks,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDhVpQaI0dwg4A47wRAgxMAKCgcX59rpVR2umCUz4IBNls8L+8EQCfQprd
4v8Qxv3890dRIus0ptIyGxs=
=AJGF
-----END PGP SIGNATURE-----
