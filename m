Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423808AbWJaTSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423808AbWJaTSz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423810AbWJaTSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:18:54 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39577 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423808AbWJaTSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:18:53 -0500
Subject: Re: scary message 'failed to recover some devices ... retrying'
	HPT370
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20061031185921.GA3636@amd64.of.nowhere>
References: <20061031185921.GA3636@amd64.of.nowhere>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Oct 2006 19:22:46 +0000
Message-Id: <1162322567.11965.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-31 am 19:59 +0100, ysgrifennodd jurriaan:
> ata11.00: ATA-6, max UDMA/100, 488397168 sectors: LBA48
> ata11.00: ata11: dev 0 multi count 16

Found the master happily

> ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata11: failed to recover some devices, retrying in 5 secs
> ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata11: failed to recover some devices, retrying in 5 secs
> ata11.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> ata11: failed to recover some devices, retrying in 5 secs

Slave probing is noisy and annoying right now because it tries too hard
but this fine (unless oyuhave a slave device)

Thanks for the report. I'll review the drive detect for the chip but I
suspect it just needs to switch to the polling probe.

