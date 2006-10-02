Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWJBSFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWJBSFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWJBSFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:05:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965207AbWJBSFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:05:02 -0400
Date: Mon, 2 Oct 2006 11:04:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>, Auke Kok <auke-jan.h.kok@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] net driver updates
Message-Id: <20061002110449.bf0a47d4.akpm@osdl.org>
In-Reply-To: <20061002154831.GA8929@havoc.gtf.org>
References: <20061002154831.GA8929@havoc.gtf.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

wrong mailing list ;)

On Mon, 2 Oct 2006 11:48:31 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> 
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus
> 
> to receive the following updates:
> 
>  drivers/net/e100.c                |   82 +--
>  drivers/net/e1000/LICENSE         |  339 ------------
>  drivers/net/e1000/Makefile        |   35 +
>  drivers/net/e1000/e1000.h         |   59 +-
>  drivers/net/e1000/e1000_ethtool.c |  150 +++--
>  drivers/net/e1000/e1000_hw.c      | 1074 +++++++++++++++++--------------------
>  drivers/net/e1000/e1000_hw.h      |   86 ++-
>  drivers/net/e1000/e1000_main.c    |  271 ++++++---
>  drivers/net/e1000/e1000_osdep.h   |   35 +
>  drivers/net/e1000/e1000_param.c   |   47 +-
>  drivers/net/hp100.c               |    5 
>  drivers/net/ixgb/Makefile         |   38 +
>  drivers/net/ixgb/ixgb.h           |   38 +
>  drivers/net/ixgb/ixgb_ee.c        |   36 +
>  drivers/net/ixgb/ixgb_ee.h        |   36 +
>  drivers/net/ixgb/ixgb_ethtool.c   |   36 +
>  drivers/net/ixgb/ixgb_hw.c        |   36 +
>  drivers/net/ixgb/ixgb_hw.h        |   36 +
>  drivers/net/ixgb/ixgb_ids.h       |   36 +
>  drivers/net/ixgb/ixgb_main.c      |   46 +-
>  drivers/net/ixgb/ixgb_osdep.h     |   36 +
>  drivers/net/ixgb/ixgb_param.c     |   36 +
>  drivers/net/phy/fixed.c           |    6 
>  drivers/net/phy/phy_device.c      |    8 
>  drivers/net/sky2.c                |  548 ++++++++++++-------
>  drivers/net/sky2.h                |   62 --
>  drivers/net/spider_net.c          |    6 
>  drivers/net/wireless/airo.c       |   23 +
>  drivers/net/wireless/ipw2100.c    |   11 
>  29 files changed, 1502 insertions(+), 1755 deletions(-)
>  delete mode 100644 drivers/net/e1000/LICENSE
> 
> Auke Kok:
>       e100, e1000, ixgb: update copyright header and remove LICENSE
>       e100, e1000, ixgb: Fix an impossible memory overwrite bug
>       e1000: keep .suspend and .resume driver methods in CONFIG_PM
>       e100: rework WoL and shutdown handling
>       e1000: driver state fixes (race fix)
>       ixgb: convert to netdev_priv(netdev)
>       e100, e1000, ixgb: increment version numbers

Does this include the e100 change which caused
reboot-with-netconsole-enabled to hang?
