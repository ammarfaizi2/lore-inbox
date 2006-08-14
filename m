Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWHNQ2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWHNQ2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWHNQ2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:28:34 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:26827 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751514AbWHNQ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:28:32 -0400
Message-ID: <44E0A4AE.3080600@de.ibm.com>
Date: Mon, 14 Aug 2006 18:28:30 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
CC: linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: [PATCH 0/7] ehea: IBM eHEA Ethernet Device Driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the latest version of the IBM eHEA Ethernet Device Driver.
We got a lot of very helpful comments and modified our driver as we
said in our replies.

Thanks for your efforts so far!

Things we are still working on:
- Debug output rework (EDEB, remove unimportant debug information,
   using standard kernel mechanisms where possible)
- performance improvements on SMP systems
- error recovery

Thanks,
Jan-Bernd

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
Changelog-by:  Jan-Bernd Themann <themann@de.ibm.com>

Differences to patch set http://www.spinics.net/lists/netdev/msg10997.html

Changelog:

- Proper use of alloc_etherdev() / netdev_priv()
- Several memory leeks fixed
- Split big functions
- 64K page support
- Code cleanup (removed unnecessary casts, unused defines,
   ethtool stub functions removed, renaming prefixes, comments, ...)


  drivers/net/Kconfig             |    6
  drivers/net/Makefile            |    1
  drivers/net/ehea/Makefile       |    7
  drivers/net/ehea/ehea.h         |  470 +++++++
  drivers/net/ehea/ehea_ethtool.c |  271 ++++
  drivers/net/ehea/ehea_hcall.h   |   52
  drivers/net/ehea/ehea_hw.h      |  315 ++++
  drivers/net/ehea/ehea_main.c    | 2672 ++++++++++++++++++++++++++++++++++++++++
  drivers/net/ehea/ehea_phyp.c    | 1087 ++++++++++++++++
  drivers/net/ehea/ehea_phyp.h    |  562 ++++++++
  drivers/net/ehea/ehea_qmr.c     |  757 +++++++++++
  drivers/net/ehea/ehea_qmr.h     |  392 +++++
  12 files changed, 6592 insertions(+)






