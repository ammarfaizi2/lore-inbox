Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTFJPwC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTFJPwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:52:02 -0400
Received: from [81.11.134.227] ([81.11.134.227]:51462 "EHLO italy.lashout.net")
	by vger.kernel.org with ESMTP id S263271AbTFJPvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:51:43 -0400
Subject: Re: siI3112 crash on enabling dma
From: Adriaan Peeters <apeeters@lashout.net>
Reply-To: apeeters@lashout.net
To: linux-kernel@vger.kernel.org
In-Reply-To: <1054929160.1793.121.camel@localhost>
References: <1054929160.1793.121.camel@localhost>
Content-Type: text/plain
Organization: 
Message-Id: <1055261120.28365.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jun 2003 18:05:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-06 at 21:52, Adriaan Peeters wrote:
> Hello,
> 
> I'm using 2.4.20-ac2, when I boot the system, SATA disks on a sil3112
> controller (IWill IS150-R) are detected, but dma is not enabled.
> The disks work perfectly in raid 1 mode, and I can enable dma using 
> hdparm -X66 -d1 /dev/hda
> hdparm -X66 -d1 /dev/hdc
> 
> But sometimes this fails and the entire system hangs. I suspect it
> happens when I enable dma mode while there is some harddisk activity.

The system seemed to be stable for a few days, but then the following
happened:
- First I got read-only filesystem messages
- a few seconds later I/O errors
- After rebooting, the root filesystem (ext3) could not be mounted
- After fscking and a lot of deleted inodes, large portions of the
filesystem were gone to lost+found (/etc, /bin, ...)

I can only relate this to the driver, it seems very unstable :(

Some info: 2.4.20-ac2, asus a7v8x motherboard (onboard promise raid not
used), iwill IS150-R raid controler, 2 Maxtor 6Y080M0 SATA disks in
raid1.

-- 
Adriaan Peeters <apeeters@lashout.net>

