Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTFYBKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTFYBKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:10:14 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:61326 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263452AbTFYBKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:10:06 -0400
Date: Tue, 24 Jun 2003 20:58:08 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Fixes for 2.5.73
Message-ID: <20030624205808.GB14945@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This release contains fixes for ALSA compilation and also removes
a bug in the locking code.

Please Pull from: bk://linux-pnp.bkbits.net/pnp-2.5

Thanks,
Adam

 drivers/pnp/interface.c    |    6 +++---
 drivers/pnp/isapnp/core.c  |    4 ++--
 drivers/pnp/manager.c      |   14 ++++++--------
 drivers/pnp/pnpbios/core.c |    2 +-
 drivers/pnp/support.c      |    2 +-
 include/linux/pnp.h        |    4 ++--
 6 files changed, 15 insertions(+), 17 deletions(-)

through these ChangeSets:

ChangeSet@1.1388, 2003-06-24 20:24:19+00:00, ambx1@neo.rr.com
  [PNP] Locking Fixes
  
  The semaphore in pnp_init_resource_table is not needed and, in some
  cases, can cause resource management lockups.  This patch removes the
  improperly placed semaphore.

 drivers/pnp/manager.c |    2 --
 1 files changed, 2 deletions(-)


ChangeSet@1.1387, 2003-06-24 20:17:15+00:00, ambx1@neo.rr.com
  [PNP] pnp_init_resource_table compile fix
  
  In the last release, this api was accidently changed and therefore 
  affected some drivers.  This patch corrects the issue by renaming
  the api back to pnp_init_resource_table.

 drivers/pnp/interface.c    |    6 +++---
 drivers/pnp/isapnp/core.c  |    4 ++--
 drivers/pnp/manager.c      |   12 ++++++------
 drivers/pnp/pnpbios/core.c |    2 +-
 drivers/pnp/support.c      |    2 +-
 include/linux/pnp.h        |    4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)
