Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUCKVg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUCKVg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:36:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:11485 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261742AbUCKVgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:36:10 -0500
X-Authenticated: #20450766
Date: Thu, 11 Mar 2004 22:35:05 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Brad Cramer <bcramer@callahanfuneralhome.com>
cc: linux-kernel@vger.kernel.org, <linux-scsi-owner@vger.kernel.org>
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
In-Reply-To: <008801c3fd40$933d2ca0$6501a8c0@office>
Message-ID: <Pine.LNX.4.44.0403112227560.4114-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Brad Cramer wrote:

> I installed a debian kernel image (kernel_image-2.4.24-1-k7) to tell if this
> was just a problem with the driver or because of the upgrade to kernel 2.6.x
> I the sym53c8xx and sym53c8xx_2 drivers are modules and this is what I got.

...

> bigdaddy:~# mount /var
> reiserfs: found format "3.6" with standard journal
> reiserfs: checking transaction log (device sd(8,2)) ...
> for (sd(8,2))
> SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
> Current sd08:02: sense key Aborted Command
> Additional sense indicates Scsi parity error
> I/O error: dev 08:02, sector 65680
> sd(8,2):reiserfs: journal-837: IO error during journal replay
> sd(8,2):Replay Failure, unable to mount
> sd(8,2):sh-2022: reiserfs_read_super: unable to initialize journal space
> mount: wrong fs type, bad option, bad superblock on /dev/sda2,
>         or too many mounted file systems

Ok, still hoping to attract the help from some more experienced in SCSI
and more knowledgable about this specific driver, here's one more thing I
can suggest - can you enable debugging through the respective /proc-files
(see, e.g., drivers/scsi/sym53c8xx_2/Documentation.txt in 2.4). I guess,
useful would be tiny,result,queue. Possibly, for both drivers, but be
prepared - for the working one it'll produce lots of output, I guess...

Thanks
Guennadi
---
Guennadi Liakhovetski


