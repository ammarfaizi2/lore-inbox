Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTHYNtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 09:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbTHYNtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 09:49:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23220 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261821AbTHYNth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 09:49:37 -0400
Date: Mon, 25 Aug 2003 14:49:36 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Niklas Vainio <niklas.vainio@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test4] VFS: Cannot open root device
Message-ID: <20030825134936.GI454@parcelfarce.linux.theplanet.co.uk>
References: <20030825130331.GA20696@vinku.pingviini.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825130331.GA20696@vinku.pingviini.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 04:03:31PM +0300, Niklas Vainio wrote:
> I get this at boot with 2.6.0-test[3,4]:
> 
> VFS: Cannot open root device "341" or unknown-block(3,65) for ext3 error=-6
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on unknown-block(3,65)
> 
> Before this, kernel seems to detect hard disks just fine.
> 
> This system boots fine with 2.2 and 2.4 kernels. I have tried setting
> root=/dev/hdb1 and rootfstype=ext2 (hdb1 is ext2) but this doesn't help.
> Config below. Is something missing?

> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y

> # CONFIG_BLK_DEV_IDEDISK is not set

This.  IDE driver will find the hardware, all right, but there will be
nothing that would know how to talk with IDE disks.
