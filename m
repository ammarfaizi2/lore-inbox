Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268012AbTBWCnx>; Sat, 22 Feb 2003 21:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268013AbTBWCnx>; Sat, 22 Feb 2003 21:43:53 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:34475 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S268012AbTBWCnw>;
	Sat, 22 Feb 2003 21:43:52 -0500
Date: Sat, 22 Feb 2003 21:52:59 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [BK PATCH] Additional PnP Changes for 2.5.62
Message-ID: <20030222215259.GA1212@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This set of changes fixes stack memory usage and contains a couple minor
resource management fixes.

Please Pull from: bk://linux-pnp.bkbits.net/linus-2.5

Thanks,
Adam



 drivers/pnp/interface.c |   41 ++++++++++++++++++-----------------------
 drivers/pnp/manager.c   |   32 +++++++++++++++++++++-----------
 drivers/pnp/resource.c  |    8 ++++----
 3 files changed, 43 insertions(+), 38 deletions(-)

through these ChangeSets:

ChangeSet@1.1025, 2003-02-22 21:40:51+00:00, ambx1@neo.rr.com
  Resource Management Performance Fix
  
  Fixes a typo in pnp_check_*_conflicts functions.  Without this fix the
  resource algorithm will work but will take longer to assign resources.
  
  Also contains some minor reordering in pnp_activate_dev.

 drivers/pnp/manager.c  |    9 +++++----
 drivers/pnp/resource.c |    8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)


ChangeSet@1.1024, 2003-02-22 21:33:56+00:00, ambx1@neo.rr.com
  Large Stack Usage Fix
  
  Reduces the stack memory usage in the following PnP Functions:
  pnp_printf
  pnp_set_current_resources
  pnp_manual_config_dev
  pnp_activate_dev

 drivers/pnp/interface.c |   41 ++++++++++++++++++-----------------------
 drivers/pnp/manager.c   |   23 ++++++++++++++++-------
 2 files changed, 34 insertions(+), 30 deletions(-)
