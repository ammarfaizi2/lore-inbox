Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUFLOg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUFLOg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUFLOg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 10:36:57 -0400
Received: from tench.street-vision.com ([212.18.235.100]:49025 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S264821AbUFLOgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 10:36:55 -0400
Subject: Re: Serial ATA (SATA) on Linux status report (2.6.x mainstream
	plan for AHCI and iswraid??)
From: Justin Cormack <justin@street-vision.com>
To: Andre Tomt <andre@tomt.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <40C9193F.9080107@tomt.net>
References: <20040610155740.81227.qmail@web90109.mail.scd.yahoo.com>
	 <40C8A5F6.3030002@pobox.com>  <40C9193F.9080107@tomt.net>
Content-Type: text/plain
Message-Id: <1087051010.25334.4.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 12 Jun 2004 15:36:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-11 at 03:30, Andre Tomt wrote:
> Since we're on the topic of new libata drivers, how is the Marvell 
> driver coming along? I'm getting several server units with a 4-port 
> version on-board in the not-so-distant future, it would be nice if they 
> could use all their drive bays ;-)

Though not as useful as a libata driver (and not GPL, though the license
is entirely unrestrictive), there is an open source driver for the
Marvell chipsets:

http://www.highpoint-tech.com/BIOS%20%2B%20Driver/rr1820a/Linux/rr182x-openbuild-v1.02.tgz

It wont build on 2.6 due to cli/sti (v. easy to fix though - its just
the irq locking), and it only supports 8 channel chips (only a few
#defines for PCI ids and number of ports). Intend to fix it up and test
it next week if the libata driver not out, as I have a few of these. The
highpoint card is the first PCI-X SATA card I have actually managed to
get hold of, but unlike other highpoint cards is not their chipset:

03:02.0 SCSI storage controller: Marvell MV88SX5081 8-port SATA I PCI-X
Controller (rev 03)


