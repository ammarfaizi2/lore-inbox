Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTIROjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 10:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTIROjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 10:39:13 -0400
Received: from public1-brig1-3-cust85.lond.broadband.ntl.com ([80.0.159.85]:16545
	"EHLO ppg_penguin.kenmoffat.uklinux.net") by vger.kernel.org
	with ESMTP id S261509AbTIROjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 10:39:09 -0400
Date: Thu, 18 Sep 2003 15:39:08 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-pre4 problems on i686 (net drivers, dri)
Message-ID: <Pine.LNX.4.58.0309181515510.27140@ppg_penguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if this is already known, I'm not following this list closely
at the moment.  I've just tried -pre4 on an i686, with the following
results:

1. depmod reports missing symbols (crc32_le and bitreverse) for 8139cp,
8139too, fealnx, tulip, via-rhine, winbond849.  I'm willing to believe
the config tools have let me not select something here.  Fortunately, my
current nic on this box is natsemi, which is working.

2. I thought the changes for XFree-4.3 dri were in by now, but the
options in menuconfig seemed a bit vague on this.  I know other arches
are having problems, but I thought x86 was ok so I gave it a go using
radeon.o - bad news, if my XF86Config tells it to load module "dri" it
locks the box solid.

The card is a radeon-7500ish, my XF86Config and this part of the .config
haven't changed for some time, I've been used to building X's radeon.o
if I wanted dri to work.

.config has
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_RADEON=m

Suggestions welcome, other info on request.

Ken
-- 
 Peace, love, linux



