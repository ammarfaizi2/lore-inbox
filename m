Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285277AbRLFXHs>; Thu, 6 Dec 2001 18:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285275AbRLFXHb>; Thu, 6 Dec 2001 18:07:31 -0500
Received: from hera.cwi.nl ([192.16.191.8]:17859 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S285254AbRLFXHO>;
	Thu, 6 Dec 2001 18:07:14 -0500
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
From: Hein Roehrig <hein@acm.org>
To: linux-kernel@vger.kernel.org
Subject: network interface names ethX and renaming interfaces
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Dec 2001 00:05:32 +0100
Message-Id: <E16C7a8-00014B-00@qaip3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello *,

in Linux 2.2.20 I have a problem renaming the network interface dummy0
to eth0 and then starting a regular ethernet driver --- I would like
it to come up as eth1 but it comes up as eth0, messing up the dummy0
interface.

Reading the source, it appears that in init_ethernev(), ethernet
drivers claim device names according to the array ethdev_index and
shoot down any device name eth0 claimed by a non-ethernet driver.

Therefore it appears to me that SIOCSIFNAME should either disallow
renaming to ethX or it should adjust ethdev_index.

Thanks in advance for any comment/advice,
Hein


