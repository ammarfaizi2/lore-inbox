Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSFTHL2>; Thu, 20 Jun 2002 03:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318136AbSFTHL1>; Thu, 20 Jun 2002 03:11:27 -0400
Received: from test.inspired.net.au ([216.122.33.55]:34245 "EHLO
	test.inspired.net.au") by vger.kernel.org with ESMTP
	id <S318135AbSFTHLZ>; Thu, 20 Jun 2002 03:11:25 -0400
Message-Id: <200206200711.RAA10165@thucydides.inspired.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Jun 2002 17:09:44 +1000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <Pine.LNX.4.33.0206192149410.2638-100000@penguin.transmeta.com>
References: <20020620004442.GA19824@gum01m.etpnet.phys.tue.nl>
	<Pine.LNX.4.33.0206192149410.2638-100000@penguin.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.90.3
From: "Martin Schwenke" <martin@meltin.net>
Reply-To: "Martin Schwenke" <martin@meltin.net>
X-Music: john_butler_trio / three / money
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@transmeta.com> writes:

    Linus> Can't you add the SCSI devices to the device tree, and be
    Linus> done with it? 

Do you mean the /devices tree or the Open Firmware (OF) device-tree
(as in IEEE Std 1275).  I suspect that you mean the former, but...

    Linus> [...]

    Linus> All fixed at least to _some_ degree by giving the most
    Linus> complete address we can, ie something like

    Linus> 	/devices/root/pci0/00:02.0/02:1f.0/03:07.0

That looks similar, but not identical to an Open Firmware node for a
SCSI device:

  device-tree/pci@3fff5e09000/pci@b,6/scsi@1,1/sd/...

Why not use the structure of, and a subset of the capabilities of, an
OF device-tree for building /devices?  It's a little more verbose, but
it's a standard and it fits the current problem pretty well.

I've been working on some hardware inventory stuff at IBM that uses an
augmented OF device-tree (as a directory tree in userspace) to keep
track of useful stuff...

peace & happiness,
martin
