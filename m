Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVF0V2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVF0V2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVF0V1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:27:07 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:29191 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261895AbVF0VZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:25:03 -0400
Date: Mon, 27 Jun 2005 23:25:06 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Moving hardware monitoring drivers to drivers/hwmon (2/3)
Message-Id: <20050627232506.084d4fc0.khali@linux-fr.org>
In-Reply-To: <20050627224003.4b1ce717.khali@linux-fr.org>
References: <20050627224003.4b1ce717.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This second patch moves the hardware monitoring drivers themselves from
drivers/i2c/chips to drivers/hwmon.

The patch being very large (1.6 MB) and rather uninteresting (it's
really only moving files), I am not including it here. You can get it
from:

http://jdelvare.net1.nerim.net/sensors/linux-2.6.12-git5-hwmon-move-all-drivers-2-drv.diff.gz

 drivers/hwmon/adm1021.c        |  402 +++++++++
 drivers/hwmon/adm1025.c        |  577 +++++++++++++
 drivers/hwmon/adm1026.c        | 1714 +++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/adm1031.c        |  977 +++++++++++++++++++++++
 drivers/hwmon/adm9240.c        |  791 ++++++++++++++++++
 drivers/hwmon/asb100.c         | 1065 +++++++++++++++++++++++++
 drivers/hwmon/atxp1.c          |  361 ++++++++
 drivers/hwmon/ds1621.c         |  341 ++++++++
 drivers/hwmon/fscher.c         |  691 ++++++++++++++++
 drivers/hwmon/fscpos.c         |  641 +++++++++++++++
 drivers/hwmon/gl518sm.c        |  604 ++++++++++++++
 drivers/hwmon/gl520sm.c        |  769 ++++++++++++++++++
 drivers/hwmon/it87.c           | 1184 ++++++++++++++++++++++++++++
 drivers/hwmon/lm63.c           |  597 ++++++++++++++
 drivers/hwmon/lm75.c           |  296 +++++++
 drivers/hwmon/lm75.h           |   49 +
 drivers/hwmon/lm77.c           |  420 ++++++++++
 drivers/hwmon/lm78.c           |  795 +++++++++++++++++++
 drivers/hwmon/lm80.c           |  601 ++++++++++++++
 drivers/hwmon/lm83.c           |  408 +++++++++
 drivers/hwmon/lm85.c           | 1575 +++++++++++++++++++++++++++++++++++++
 drivers/hwmon/lm87.c           |  828 +++++++++++++++++++
 drivers/hwmon/lm90.c           |  655 +++++++++++++++
 drivers/hwmon/lm92.c           |  429 ++++++++++
 drivers/hwmon/max1619.c        |  372 ++++++++
 drivers/hwmon/pc87360.c        | 1348 ++++++++++++++++++++++++++++++++
 drivers/hwmon/sis5595.c        |  817 +++++++++++++++++++
 drivers/hwmon/smsc47b397.c     |  352 ++++++++
 drivers/hwmon/smsc47m1.c       |  593 ++++++++++++++
 drivers/hwmon/via686a.c        |  875 ++++++++++++++++++++
 drivers/hwmon/w83627ehf.c      |  846 ++++++++++++++++++++
 drivers/hwmon/w83627hf.c       | 1511 ++++++++++++++++++++++++++++++++++++
 drivers/hwmon/w83781d.c        | 1632 +++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/w83l785ts.c      |  328 +++++++
 drivers/i2c/chips/adm1021.c    |  402 ---------
 drivers/i2c/chips/adm1025.c    |  577 -------------
 drivers/i2c/chips/adm1026.c    | 1714 -----------------------------------------
 drivers/i2c/chips/adm1031.c    |  977 -----------------------
 drivers/i2c/chips/adm9240.c    |  791 ------------------
 drivers/i2c/chips/asb100.c     | 1065 -------------------------
 drivers/i2c/chips/atxp1.c      |  361 --------
 drivers/i2c/chips/ds1621.c     |  341 --------
 drivers/i2c/chips/fscher.c     |  691 ----------------
 drivers/i2c/chips/fscpos.c     |  641 ---------------
 drivers/i2c/chips/gl518sm.c    |  604 --------------
 drivers/i2c/chips/gl520sm.c    |  769 ------------------
 drivers/i2c/chips/it87.c       | 1184 ----------------------------
 drivers/i2c/chips/lm63.c       |  597 --------------
 drivers/i2c/chips/lm75.c       |  296 -------
 drivers/i2c/chips/lm75.h       |   49 -
 drivers/i2c/chips/lm77.c       |  420 ----------
 drivers/i2c/chips/lm78.c       |  795 -------------------
 drivers/i2c/chips/lm80.c       |  601 --------------
 drivers/i2c/chips/lm83.c       |  408 ---------
 drivers/i2c/chips/lm85.c       | 1575 -------------------------------------
 drivers/i2c/chips/lm87.c       |  828 -------------------
 drivers/i2c/chips/lm90.c       |  655 ---------------
 drivers/i2c/chips/lm92.c       |  429 ----------
 drivers/i2c/chips/max1619.c    |  372 --------
 drivers/i2c/chips/pc87360.c    | 1348 --------------------------------
 drivers/i2c/chips/sis5595.c    |  817 -------------------
 drivers/i2c/chips/smsc47b397.c |  352 --------
 drivers/i2c/chips/smsc47m1.c   |  593 --------------
 drivers/i2c/chips/via686a.c    |  875 --------------------
 drivers/i2c/chips/w83627ehf.c  |  846 --------------------
 drivers/i2c/chips/w83627hf.c   | 1511 ------------------------------------
 drivers/i2c/chips/w83781d.c    | 1632 ---------------------------------------
 drivers/i2c/chips/w83l785ts.c  |  328 -------
 68 files changed, 25444 insertions(+), 25444 deletions(-)



-- 
Jean Delvare
