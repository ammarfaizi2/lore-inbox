Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422670AbVLOMbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbVLOMbj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 07:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbVLOMbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 07:31:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:10718 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965199AbVLOMbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 07:31:39 -0500
Subject: Re: HPT374 RAID bus controller SATA, only UDMA 33
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lukas Postupa <postupa@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7553.1134610410@www88.gmx.net>
References: <7553.1134610410@www88.gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Dec 2005 12:31:55 +0000
Message-Id: <1134649915.12421.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-15 at 02:33 +0100, Lukas Postupa wrote:
> Hi,
> 
> my SAMSUNG 250GB drive connected to HPT374 RAID bus controller (SATA) is
> only working at UDMA 33.

The HPT37x driver in the old IDE code assumes cable detection support.
If someone uses a SATA bridge that gets this wrong then you don't get
over 33Mhz.

> Does anyone have a solution to fix this bottleneck?

Force ata66 support on. See Documentation/ide.txt

