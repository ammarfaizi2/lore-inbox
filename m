Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUAPDrr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 22:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUAPDrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 22:47:47 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:6027 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S265264AbUAPDrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 22:47:46 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16391.24288.194579.471295@jik.kamens.brookline.ma.us>
Date: Thu, 15 Jan 2004 22:47:44 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Updated on UDMA BadCRC errors + subsequent problems
  (was: Is it safe to ignore UDMA BadCRC errors?)
In-Reply-To: <16389.63781.783923.930112@jik.kamens.brookline.ma.us>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
	<16389.63781.783923.930112@jik.kamens.brookline.ma.us>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The drive which stopped reporting BadCRC errors for weeks when I
transferred it from the Promise PDC20262 Ultra66 controller to the
SIIG SIi680 Ultra133 controller just reported this:

Jan 15 22:03:13 jik kernel: hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Jan 15 22:03:13 jik kernel: hde: drive_cmd: error=0x04 { DriveStatusError }
Jan 15 22:03:20 jik kernel: hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Jan 15 22:03:20 jik kernel: hde: drive_cmd: error=0x04 { DriveStatusError }

I don't know whether it's relevant that these errors are tagged
"drive_cmd" and the BadCRC errors were tagged "dma_intr".

Are the errors above close enough to the BadCRC errors I was getting,
i.e.:

  hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }

for me to now start suspecting a problem with the drive, given that
two different controllers with two different chipsets are reporting
problems with it?

Thanks,

  Jonathan Kamens
