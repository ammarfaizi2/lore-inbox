Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVAYAok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVAYAok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVAYAoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:44:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:45272 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261749AbVAYAkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:40:46 -0500
Date: Mon, 24 Jan 2005 16:45:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Page fault in umount
Message-Id: <20050124164524.3589856a.akpm@osdl.org>
In-Reply-To: <41F1A90D.5000809@drzeus.cx>
References: <41F1A90D.5000809@drzeus.cx>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>
> When I yank out my MP3 player, the programs trying to umount the disk 
> cause the following page fault:
> 
> ...
> EIP is at scsi_device_put+0xf/0x70 [scsi_mod]

This should be fixed in 2.6.11-rc2-mm1, via bk-scsi-rc-fixes.patch.  Could you
retest with either

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm1/2.6.11-rc2-mm1.bz2

or

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm1/broken-out/bk-scsi-rc-fixes.patch

applied?
