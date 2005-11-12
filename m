Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVKLRvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVKLRvI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 12:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVKLRvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 12:51:08 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:13263 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932433AbVKLRvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 12:51:06 -0500
Subject: Re: [2.6 patch] removed useless SCSI_GENERIC_NCR5380_MMIO
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051112043707.GX5376@stusta.de>
References: <20051112043707.GX5376@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 12 Nov 2005 18:20:25 +0000
Message-Id: <1131819625.18258.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-11-12 at 05:37 +0100, Adrian Bunk wrote:
> This patch removes the useless SCSI_GENERIC_NCR5380_MMIO.
> 
> It's useless, since SCSI_G_NCR5380_MEM != CONFIG_SCSI_G_NCR5380_MEM.
> 
> This issue exists at least since kernel 2.6.0 and since it seems noone 
> noticed it I'd say we can safely remove it.


Its a one line bugfix so make the bugfix. There are often drivers that
needed tiny fixes and it turned out that

- Vendors had it in their patch tree for years
- The one person using it fixed it and didnt bother telling l/k cos they
though l/k was full of arrogant assholes who would just laugh at them
- The few users are still on 2.4 but will move to 2.6

Now when its a major rewrite to fix up some prehistoric piece of crap it
makes sense to dump it if nobody uses it, when you have a one line fix
required its a bit daft not to fix it.

Alan
