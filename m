Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWDSKqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWDSKqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 06:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWDSKqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 06:46:13 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:13243 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750702AbWDSKqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 06:46:11 -0400
Message-ID: <444614F2.4030607@dgreaves.com>
Date: Wed, 19 Apr 2006 11:46:10 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very strange RAID failure
References: <20060419070522.GL10304@vitelus.com>
In-Reply-To: <20060419070522.GL10304@vitelus.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> I came back to my machine a few days ago and noticed strange behavior,
> and then found this in the logs:
>
>
> Apr 16 07:02:50 annexia kernel: ata1: command 0x35 timeout, stat 0x51 host_stat 0x60
> Apr 16 07:02:50 annexia kernel: ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> Apr 16 07:02:50 annexia kernel: ata1: status=0x51 { DriveReady SeekComplete Error }
> Apr 16 07:02:50 annexia kernel: ata1: error=0x04 { DriveStatusError }
> Apr 16 07:02:50 annexia kernel: sd 0:0:0:0: SCSI error: return code = 0x8000002
> Apr 16 07:02:50 annexia kernel: sda: Current: sense key: Aborted Command
> Apr 16 07:02:50 annexia kernel:     Additional sense: No additional sense information
> Apr 16 07:02:50 annexia kernel: end_request: I/O error, dev sda, sector 625137194
> Apr 16 07:02:50 annexia kernel: raid5: Disk failure on sda4, disabling device. Operation continuing on 3 devices
> Apr 16 07:02:50 annexia kernel: RAID5 conf printout:
> Apr 16 07:02:50 annexia kernel:  --- rd:4 wd:3 fd:1
> Apr 16 07:02:50 annexia kernel:  disk 0, o:0, dev:sda4
> Apr 16 07:02:50 annexia kernel:  disk 1, o:1, dev:sdd4
> Apr 16 07:02:50 annexia kernel:  disk 2, o:1, dev:sdb4
> Apr 16 07:02:50 annexia kernel:  disk 3, o:1, dev:sdc4
go and search linux-ide for messages from me.
It looks similar to problems I've had that turned out to be 2.6.15
libata/fua bug.

David

-- 

