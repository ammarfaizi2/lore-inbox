Return-Path: <linux-kernel-owner+w=401wt.eu-S1422634AbXAERem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbXAERem (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbXAERem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:34:42 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:2810 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422634AbXAERel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:34:41 -0500
Date: Fri, 5 Jan 2007 18:34:39 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux I2C <i2c@lm-sensors.org>
Subject: Re: [i2c] [GIT PULL] More i2c updates for 2.6.20
Message-Id: <20070105183439.29f41f0b.khali@linux-fr.org>
In-Reply-To: <20070104132806.79cf015e.khali@linux-fr.org>
References: <20070104132806.79cf015e.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the i2c subsystem updates for Linux 2.6.20 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

(This requests replaces the one from yesterday, as I received two urgent
fixes since then.)

These are late fixes that I want to have in 2.6.20, fixing compilation
breakage of the new i2c-pnx bus driver, a random oops in i2c-mv64xxx,
a bug in the m41t00 clock driver, and helping compatibility with
regards to planned i2c-core cleanups.

 Documentation/feature-removal-schedule.txt |   17 +++++++++++++++++
 MAINTAINERS                                |    6 ++++++
 drivers/i2c/busses/Kconfig                 |    9 ---------
 drivers/i2c/busses/i2c-mv64xxx.c           |    4 ++--
 drivers/i2c/busses/i2c-pnx.c               |    7 +------
 drivers/i2c/chips/m41t00.c                 |    1 +
 drivers/i2c/i2c-core.c                     |   28 ++++++++++++++++++++++++----
 7 files changed, 51 insertions(+), 21 deletions(-)

---------------

David Brownell:
      i2c: Migration aids for i2c_adapter.dev removal

Maxime Bizon:
      i2c-mv64xxx: Fix random oops at boot

Philippe De Muyter:
      i2c/m41t00: Do not forget to write year

Vitaly Wool:
      i2c-pnx: Fix interrupt handler, get rid of EARLY config option
      i2c-pnx: Add entry to MAINTAINERS

Thanks,
-- 
Jean Delvare
