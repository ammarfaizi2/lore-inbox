Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBGQdq>; Wed, 7 Feb 2001 11:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbRBGQdh>; Wed, 7 Feb 2001 11:33:37 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:48135 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129031AbRBGQdV>; Wed, 7 Feb 2001 11:33:21 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE00C@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'John R Lenton'" <john@grulic.org.ar>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: different IRQ settings for different MPS settings?
Date: Wed, 7 Feb 2001 08:32:32 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: John R Lenton [mailto:john@grulic.org.ar]
> 
> With a MPS setting of 1.4 USB doesn't work on me; it timeouts,
> constantly.  With MPS setting of 1.1 everything is OK.
> 
...
> 
> My question(s) is(are) is this a known bug, is this correct
> behaviour, am I missing something, and why is USB the only
> subsystem affected.

It is known that several systems have problems with USB if
MPS is set to 1.4, and some systems work OK with that
setting.  Problem cause is still unknown.

I'd be interested to see you boot logs (kernel messages,
specifically MP table info) from Linux boots with
MPS = 1.1 and 1.4, to see if there are any differences
in them.  The big difference should be the addition
of some address space mappings, which Linux ignores
(doesn't parse, doesn't use) -- but I've never seen
a BIOS that implements address space mappings in the
MP table [and if one did, it looks like Linux would
just loop forever in smp_read_mpc(), so that's probably
not the issue here].

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
