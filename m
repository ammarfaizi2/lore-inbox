Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVDUJ63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVDUJ63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 05:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVDUJ63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 05:58:29 -0400
Received: from witte.sonytel.be ([80.88.33.193]:40357 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261234AbVDUJ6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 05:58:17 -0400
Date: Thu, 21 Apr 2005 11:58:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] kill old EH constants
In-Reply-To: <200504210608.j3L682Br002585@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0504211155440.13231@numbat.sonytel.be>
References: <200504210608.j3L682Br002585@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2005, Linux Kernel Mailing List wrote:
> tree 932c6f9689fd08a7a9d689cfbec8682ccde8175d
> parent 84011ae88da62a20b3ae7b48e2ae3b1ef0fc810a
> author <hch@lst.de> Mon, 11 Apr 2005 08:19:25 -0500
> committer James Bottomley <jejb@titanic> Sun, 17 Apr 2005 06:14:52 -0500
> 
> [PATCH] kill old EH constants
> 
> Fix up two drivers that incorrectly were using the old return values for
> their new-style EH methods and kill off scsi_obsolete.h that defined the
> constants.  The initio driver has all these constansts defined locally
> and uses them internally, I'll fix that up some time later.
> 
> Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

sun3_NCR5380.c still uses the following:

  - SCSI_ABORT_SUCCESS
  - SCSI_ABORT_ERROR
  - SCSI_ABORT_SNOOZE
  - SCSI_ABORT_BUSY
  - SCSI_ABORT_NOT_RUNNING
  - SCSI_RESET_SUCCESS
  - SCSI_RESET_BUS_RESET

causing the driver to fail to build in 2.6.12-rc3. What should I replace them
by?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
