Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269021AbSIRS4E>; Wed, 18 Sep 2002 14:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269043AbSIRS4D>; Wed, 18 Sep 2002 14:56:03 -0400
Received: from mxall.mxgrp.airmail.net ([209.196.77.106]:24843 "EHLO
	mx9.airmail.net") by vger.kernel.org with ESMTP id <S269021AbSIRS4C>;
	Wed, 18 Sep 2002 14:56:02 -0400
Date: Wed, 18 Sep 2002 14:00:54 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: config glitch with 2.4.20-pre7-ac1
Message-ID: <20020918190054.GA13013@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

There's a small glitch when configuring 2.4.20-pre7-ac1. The
problem is in drivers/mtd/devices/Config.in. menuconfig prints
out an error when configuring the kernel due to the following ...

if [ "$CONFIG_DECSTATION" = "y" ];
   dep_tristate '  DEC MS02-NV NVRAM module support' CONFIG_MTD_MS02NV
   $CONFIG_MTD $CONFIG_DECSTATION
fi

The word "then" is missing. The line should look like ...

if [ "$CONFIG_DECSTATION" = "y" ]; then
   dep_tristate '  DEC MS02-NV NVRAM module support' CONFIG_MTD_MS02NV
   $CONFIG_MTD $CONFIG_DECSTATION
fi

Art Haas
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
