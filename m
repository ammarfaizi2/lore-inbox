Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbTFQUU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbTFQUU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:20:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3798 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264926AbTFQUUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:20:20 -0400
Date: Tue, 17 Jun 2003 22:34:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>, Linux NICS <linux.nics@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Linux 2.5.72: ixgb_ethtool: strange SUPPORTED_10000baseT_Full
Message-ID: <20030617203407.GC29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  CC      drivers/net/ixgb/ixgb_ethtool.o
drivers/net/ixgb/ixgb_ethtool.c:53:1: warning: "SUPPORTED_10000baseT_Full" redefined
In file included from drivers/net/ixgb/ixgb.h:60,
                 from drivers/net/ixgb/ixgb_ethtool.c:30:
include/linux/ethtool.h:302:1: warning: this is the location of the previous definition
...

<--  snip  -->

ixgb_ethtool.c says:
  #define SUPPORTED_10000baseT_Full (1 << 11)

ethtool.h says:
  #define SUPPORTED_BNC                   (1 << 11)
  #define SUPPORTED_10000baseT_Full       (1 << 12)


The correct solution seems to be to remove the #define from 
ixgb_ethtool.c ?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

