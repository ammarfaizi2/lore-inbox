Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUFSIBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUFSIBU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 04:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUFSIBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 04:01:20 -0400
Received: from ppp2-isdn-86.the.forthnet.gr ([213.16.247.86]:42880 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S265250AbUFSIBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 04:01:19 -0400
From: V13 <v13@priest.com>
To: Adrian Almenar <aalmenar@conectium.com>
Subject: Re: sysfs directories...
Date: Sat, 19 Jun 2004 11:02:55 +0300
User-Agent: KMail/1.6.52
Cc: linux-kernel@vger.kernel.org
References: <20040618155117.0bffd01d@er-murazor.conectium.com>
In-Reply-To: <20040618155117.0bffd01d@er-murazor.conectium.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406191102.55309.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 June 2004 22:51, Adrian Almenar wrote:
> i was looking at /sys on my machine yesterday and i found something
> strange.
>
> cd
> /sys/block/hda/device/block/device/block/device/block/device/block/...
> and that continues being almost infinite and recursive, it is normal
> ???

It's a bash trick when changing dir to a symlink:

hell:/sys/block/hda$ cd device
hell:/sys/block/hda/device$ cd block
hell:/sys/block/hda/device/block$ cd device
hell:/sys/block/hda/device/block/device$ cd block
hell:/sys/block/hda/device/block/device/block$ pwd
/sys/block/hda/device/block/device/block
hell:/sys/block/hda/device/block/device/block$ /bin/pwd
/sys/block/hda
hell:/sys/block/hda/device/block/device/block/device$ pwd
/sys/block/hda/device/block/device/block/device
hell:/sys/block/hda/device/block/device/block/device$ /bin/pwd
/sys/devices/pci0000:00/0000:00:04.1/ide0/0.0

<<V13>>
