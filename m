Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSFTXAM>; Thu, 20 Jun 2002 19:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSFTXAL>; Thu, 20 Jun 2002 19:00:11 -0400
Received: from test.inspired.net.au ([216.122.33.55]:53442 "EHLO
	test.inspired.net.au") by vger.kernel.org with ESMTP
	id <S315760AbSFTXAJ>; Thu, 20 Jun 2002 19:00:09 -0400
Message-Id: <200206202259.IAA01298@thucydides.inspired.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Jun 2002 08:59:19 +1000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <Pine.LNX.4.44.0206201046340.8225-100000@home.transmeta.com>
References: <20020620165553.GA16897@win.tue.nl>
	<Pine.LNX.4.44.0206201046340.8225-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.90.3
From: "Martin Schwenke" <martin@meltin.net>
Reply-To: "Martin Schwenke" <martin@meltin.net>
X-Music: Creedence Clearwater Revival / Willy and the Poor Boys / Effigy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@transmeta.com> writes:

    Linus> But driverfs also gives information that /sbin/hotplug doesn't:

    Linus> [...]

    Linus> In other words, it's just a way of exposing information
    Linus> that the kernel already has, and that the kernel has to
    Linus> have _anyway_.

Does it have to be limited ot information that the kernel already has?

In particular, I'm thinking of the SCSI standard inquiry and EVPD
inquiry pages.  Mike Sullivan's patch does some SCSI inquiries and
extracts information from the results.  I'm wondering if the SCSI
driver could just do all of the available EVPD inquiries (available
pages are listed in the TOC on EVPD inquiry page 0), and use driverfs
to expose all of that (binary) information.

Right now the inquiries can be done from userspace using an ioctl().

peace & happiness,
martin
