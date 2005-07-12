Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVGLU43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVGLU43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVGLU4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:56:16 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:5583 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262418AbVGLUz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:55:57 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.13-rc2-mm2: kconfig: warning: defaults for choice values not supported
Date: Wed, 13 Jul 2005 06:55:45 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <9gb8d1lvbbh6m39vc2ed74fbr5ikt32ki0@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Lately in 2.6.13-rc* I've noticed a warning pop up:

grant@peetoo:/usr/src/linux-2.6.13-rc2-mm2a$ make menuconfig
...
scripts/kconfig/mconf arch/i386/Kconfig
net/ipv4/Kconfig:92:warning: defaults for choice values not supported  <<== ??
#
# using defaults found in .config
#
 Linux Kernel v2.6.13-rc2-mm2 Configuration
 ----------------------------------------------------------------------------------------------
  +------------------------------ Linux Kernel Configuration -------------------------------+
- - -
# If the user does not enable advanced routing, he gets the safe
# default of the fib-hash algorithm.
config IP_FIB_HASH
        bool
        depends on !IP_ADVANCED_ROUTER
        default y                        <<== line 92 in net/ipv4/Kconfig

config IP_MULTIPLE_TABLES
        bool "IP: policy routing"
        depends on IP_ADVANCED_ROUTER
- - -

'make oldconfig' and 'make defconfig' report same warning.

Thanks,
--Grant.

