Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSLGS0r>; Sat, 7 Dec 2002 13:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSLGS0r>; Sat, 7 Dec 2002 13:26:47 -0500
Received: from mnh-1-09.mv.com ([207.22.10.41]:35844 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264631AbSLGS0q>;
	Sat, 7 Dec 2002 13:26:46 -0500
Message-Id: <200212071837.NAA01993@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML network updates 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 07 Dec 2002 13:37:44 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/net-2.5
or	http://jdike.stearns.org:5000/net-2.5

This updates the UML networking support:
	adds help text to the UML network config options
	adds the slirp back end
	updates and cleans up the slip back end
	improves the driver's error handling
	cleans up device initialization

				Jeff

 arch/um/Kconfig_net          |  147 +++++++++++++++++++++++++++++++
 arch/um/drivers/Makefile     |   24 +----
 arch/um/drivers/net_kern.c   |  111 +++++++++++++----------
 arch/um/drivers/slip.h       |   10 +-
 arch/um/drivers/slip_kern.c  |    9 -
 arch/um/drivers/slip_proto.h |   93 +++++++++++++++++++
 arch/um/drivers/slip_user.c  |  104 +++++-----------------
 arch/um/drivers/slirp.h      |   51 ++++++++++
 arch/um/drivers/slirp_kern.c |  132 ++++++++++++++++++++++++++++
 arch/um/drivers/slirp_user.c |  202 +++++++++++++++++++++++++++++++++++++++++++
 arch/um/include/net_kern.h   |    5 +
 arch/um/include/net_user.h   |    5 +
 12 files changed, 742 insertions(+), 151 deletions(-)

ChangeSet@1.805.31.2, 2002-11-17 13:37:34-05:00, jdike@uml.karaya.com
  Copied in the new files for the slirp transport and slip cleanup.

ChangeSet@1.805.31.1, 2002-11-17 13:26:59-05:00, jdike@uml.karaya.com
  Merged the network fixes from the 2.4 pool.

ChangeSet@1.805.27.4, 2002-11-17 13:00:11-05:00, jdike@uml.karaya.com
  Moved the net changes to arch/um/drivers/Makefile into updates to a
  void a merge conflict.


