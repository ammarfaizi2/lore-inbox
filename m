Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWGPPmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWGPPmM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 11:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWGPPmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 11:42:12 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:38662 "EHLO
	smtp-vbr7.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750952AbWGPPmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 11:42:12 -0400
Date: Sun, 16 Jul 2006 17:42:10 +0200 (CEST)
From: Yuri van Oers <yvanoers@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: SCSI device order changed
Message-ID: <20060716171547.W18821-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've come across an issue which might be unintentional and in need of
fixing, in 2.6.17:

My machine has two SCSI adapters, one of which always has some disks
connected to it. One of those holds the root partition. The other card
occasionally gets some devices connected (burners and such), when I have
need for such a device.

Hard disks are sda thru sdd, the devices start at sde. That is, up until I
booted 2.6.17 _with_ the external devices attached. The kernel swapped
the order of the cards: devices start at sda, and the disks come after,
which means it can't find / on sda.

I found a related post here: http://lkml.org/lkml/2005/12/3/192
which suggests this situation arose around 2.6.15. It also says ordering
can't be guaranteed. If that's the final verdict, I'll simply swap the
cards on the PCI bus and be done with it.

So, is this a bug/problem?

Please CC me, I'm not on the list.

Thanks,
Yuri van Oers

