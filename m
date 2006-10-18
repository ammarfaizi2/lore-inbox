Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422802AbWJRUHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbWJRUHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbWJRUGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:06:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:6885 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932194AbWJRUGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:06:45 -0400
Date: Wed, 18 Oct 2006 13:06:22 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Jean Delvare <khali@linux-fr.org>
Subject: [GIT PATCH] HWMon fixes for 2.6.19-rc2
Message-ID: <20061018200622.GA10122@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some hwmon fixes for 2.6.19-rc2.

They have all been in the -mm tree for a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/hwmon-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/hwmon-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/hwmon/adm9240   |    2 -
 Documentation/hwmon/f71805f   |    2 -
 Documentation/hwmon/k8temp    |   13 ++++--
 Documentation/hwmon/smsc47m1  |    4 +-
 Documentation/hwmon/w83627ehf |    6 +--
 MAINTAINERS                   |    6 +++
 drivers/hwmon/Kconfig         |   10 +++--
 drivers/hwmon/adm9240.c       |    4 +-
 drivers/hwmon/lm78.c          |   12 +++---
 drivers/hwmon/smsc47m1.c      |   11 +++--
 drivers/hwmon/w83627ehf.c     |   11 ++++-
 drivers/hwmon/w83781d.c       |   30 ++++++++------
 drivers/hwmon/w83791d.c       |   85 +++++++++++++++++++++++++++--------------
 drivers/i2c/busses/i2c-isa.c  |    2 -
 14 files changed, 124 insertions(+), 74 deletions(-)

---------------

Grant Coady:
      adm9240: Update Grant Coady's email address

Jean Delvare:
      hwmon: Fix documentation typos
      smsc47m1: List the SMSC LPC47M112 as supported
      hwmon: Let w83781d and lm78 load again
      hwmon: Fix debug messages in w83781d

Jim Cromie:
      w83791d: Fix unchecked return status

Rudolf Marek:
      k8temp: Documentation update
      w83627ehf: Fix the detection of fan5

