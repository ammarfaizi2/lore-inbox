Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTLQLVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbTLQLVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:21:36 -0500
Received: from ANancy-107-1-16-31.w81-48.abo.wanadoo.fr ([81.48.91.31]:49338
	"EHLO joebar.freealter.fr") by vger.kernel.org with ESMTP
	id S264383AbTLQLVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:21:34 -0500
Date: Wed, 17 Dec 2003 12:20:46 +0100
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple partition not detected with 2.6
Message-ID: <20031217112046.GA31709@joebar.freealter.fr>
References: <20031215141746.GA27006@joebar.freealter.fr> <20031215170517.GA12267@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215170517.GA12267@win.tue.nl>
User-Agent: Mutt/1.3.28i
From: Ludovic Drolez <ludovic.drolez@linbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 06:05:17PM +0100, Andries Brouwer wrote:
> On Mon, Dec 15, 2003 at 03:17:46PM +0100, Ludovic Drolez wrote:
> 
> > I have one computer which has two partitions per disk.
> > This partition is seen by a 2.4.xx kernel (knoppix) but
> > not by a 2.6.0t7 kernel.
> > 
> > When booting the knoppix, dmesg says:
> > 
> > hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63
> > hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63
> > ide-cd: passing drive hde to ide-scsi emulation.
> > Partition check:
> > hda: [PTBL] [9729/255/63] hda1 hda2
> > hdc: [PTBL] [9729/255/63] hdc1 hdc2
> > 
> > 
> > But the 2.6.0t7 does not see the partition table. 
> > Other disks are properly recognized, so it seems to
> > be a problem with [PTBL] and 2.6 ...
> 
> The [PTBL] part just says that this 2.4 kernel first concluded to
> a 155061/16/63 geometry but then saw the partition table and
> changed it mind to 9729/255/63.
> It is unrelated to partition recognition.
> 
> Check that your kernel was compiled without CONFIG_PARTITION_ADVANCED,
> or, in case you selected advanced, has CONFIG_MSDOS_PARTITION selected.

Yes, I have CONFIG_PARTITION_ADVANCED, CONFIG_MSDOS_PARTITION and also LDM
partitions support.

I've attached a boot log.
In fact it seems that it's not a partitions problem but a disk
detection problem: the IDE controller is detected but not the disks...

The server is an HP-DL320 with integrated RAID IDE.

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
152 rue de Grigy - Technopole Metz 2000                   57070 METZ
tel : 03 87 75 55 21                            fax : 03 87 75 19 26
