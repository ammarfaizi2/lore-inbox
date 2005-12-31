Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVLaKFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVLaKFX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 05:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVLaKFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 05:05:23 -0500
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:31753
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S932126AbVLaKFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 05:05:22 -0500
Date: Sat, 31 Dec 2005 01:54:07 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Steven J. Hathaway" <shathawa@e-z.net>
cc: axobe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux ATAPI CDROM ->FIX: SAMSUNG CD-ROM SC-140
In-Reply-To: <43B6146C.60E044FF@e-z.net>
Message-ID: <Pine.LNX.4.10.10512310153080.22711-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Have you considered stubbing out the blacklist call for your model and how
does it behave?

Andre Hedrick
LAD Storage Consulting Group

On Fri, 30 Dec 2005, Steven J. Hathaway wrote:

> The problem first appeared in Linux 2.4.21 when the "ide-dma" source
> experienced
> a significant overhaul, but worked OK in Linux  versions 2.4.5 through
> 2.4.20.
> The problem still exists in Linux 2.4.32.
> 
> Attempts to mount a SAMSUNG SC-140 CDROM are allowing DMA which fails
> because of a problem in the following source code file:
> 
>         <linux>/drivers/ide/ide-dma.c
> 
> User sees displayed
>     mount: Directory not available
> 
> The fix is to add the following record to the drive_blacklist[] table.
> 
>      { "SAMSUNG CD-ROM SC-140",  "ALL" },
> 
> This model of SAMSUNG CD-ROM disk drive is original equipment on the
> E=Machines etower 556i2 compters, and possibly many other models.
> 
> DMA should not be performed on this CDROM model, therefore I submit
> the drive_blacklist[] request.
> 
> I had given up on upgrading Linux on this platform until the fix was
> found
> and tested.  The fix works with all Linux 2.4.21 through 2.4.32 versions
> 
> of stable kernels.
> 
> Sincerely,
> Steven J. Hathaway
> <shathawa@e-z.net>
> 
> 
> 

