Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbWHIIhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWHIIhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbWHIIhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:37:53 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:62514 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030462AbWHIIhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:37:52 -0400
Message-ID: <44D99EDE.70202@de.ibm.com>
Date: Wed, 09 Aug 2006 10:37:50 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
CC: linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: [PATCH 0/6] ehea: IBM eHEA Ethernet Device Driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is the latest version of the IBM eHEA Ethernet Device Driver.
It supports a new IBM ethernet chip on System p.
The driver has been posted on the netdev mailing list since the
beginning of June and we got little feedback so far.

Main functionality including broadcast, multicast, VLAN and most
parts of ethtool work.

Things we are still working on:
- performance improvements on SMP systems
- error recovery

In order to get this code ready for kernel inclusion we do highly
appreciate your feedback.

The patch series consists of 6 patches
01: interfaces to network stack
02: pHYP interface
03: queue management
04: header files
05: makefile
06: Kernel build (Kconfig / Makefile)

Thanks,
Jan-Bernd

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
Changelog-by:  Jan-Bernd Themann <themann@de.ibm.com>

Differences to patch set http://www.spinics.net/lists/netdev/msg06715.html
Changelog:

- Memory Region struct introduced
- Shared Memory Regions for send and receive path included
- Memory Region registeration now processes 512 pages per H_CALL
-.RQ2_PKT_SIZE changed to 1522 bytes
- NET_IP_ALIGN included
- Adaption to latest kernel (gso_size)
- minor changes (coding style, code cleanup)


  drivers/net/Kconfig             |    6
  drivers/net/Makefile            |    1
  drivers/net/ehea/Makefile       |    7
  drivers/net/ehea/ehea.h         |  452 ++++++
  drivers/net/ehea/ehea_ethtool.c |  325 ++++
  drivers/net/ehea/ehea_hcall.h   |   52
  drivers/net/ehea/ehea_hw.h      |  319 ++++
  drivers/net/ehea/ehea_main.c    | 2738 ++++++++++++++++++++++++++++++++++++++++
  drivers/net/ehea/ehea_phyp.c    | 1130 ++++++++++++++++
  drivers/net/ehea/ehea_phyp.h    |  573 ++++++++
  drivers/net/ehea/ehea_qmr.c     |  798 +++++++++++
  drivers/net/ehea/ehea_qmr.h     |  381 +++++
  12 files changed, 6782 insertions(+)







