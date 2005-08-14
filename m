Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVHNOAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVHNOAV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 10:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVHNOAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 10:00:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:33480 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932454AbVHNOAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 10:00:21 -0400
Subject: Re: IT8212/ITE RAID
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <42FF3CBA.1030900@gentoo.org>
References: <20050814053017.GA27824@zip.com.au>
	 <42FF263A.8080009@gentoo.org> <20050814114733.GB27824@zip.com.au>
	 <42FF3CBA.1030900@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 14 Aug 2005 14:33:05 +0100
Message-Id: <1124026385.14138.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-08-14 at 13:44 +0100, Daniel Drake wrote:
> > [227523.229557] hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, BUG

Thats probably the fact other patches from -ac are missing in base. It
should be harmless. 

> > [227523.229631] hda: cache flushes not supported
> > [227523.229932]  hda:hda: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> > [227523.230905] hda: recal_intr: error=0x04 { DriveStatusError }
> > [227523.230952] ide: failed opcode was: unknown

Yep - on my "wtf" list. In some cases we send a strange command to the
IT8212 drive. I'm still trying to find the guilty command we send (none
of my drives do this), so that I can fix the ident adjustment to stop
it. The noise is just the command being rejected which is ok but messy
and wants stomping.

What does a full identify data set for the drive look like ?


