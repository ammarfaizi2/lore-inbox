Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030560AbWBNKnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560AbWBNKnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030562AbWBNKnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:43:47 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:44621 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030560AbWBNKnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:43:46 -0500
Date: Tue, 14 Feb 2006 11:43:45 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is my SATA/400GB drive dying?
Message-ID: <20060214104345.GM3209@harddisk-recovery.com>
References: <Pine.LNX.4.64.0602130658110.21652@p34> <Pine.LNX.4.64.0602132016350.2607@p34> <Pine.LNX.4.64.0602132018290.2607@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602132018290.2607@p34>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 08:18:47PM -0500, Justin Piszcz wrote:
> Still get the errors:
> 
> [ 2311.980127] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
> 0xb/00/00
> [ 2311.980134] ata3: status=0x51 { DriveReady SeekComplete Error }
> [ 2311.980138] ata3: error=0x04 { DriveStatusError }

FWIW, this could be related to smartctl trying to monitor the disk.
Try this:

  smartctl -d ata -a /dev/sdX

If that complains about SMART being disabled, enable it with:

  smartctl -d ata -e /dev/sdX


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
