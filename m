Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314201AbSDZVYC>; Fri, 26 Apr 2002 17:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314211AbSDZVYB>; Fri, 26 Apr 2002 17:24:01 -0400
Received: from air-2.osdl.org ([65.201.151.6]:15620 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314201AbSDZVYB>;
	Fri, 26 Apr 2002 17:24:01 -0400
Date: Fri, 26 Apr 2002 14:17:53 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Wakko Warner <wakko@animx.eu.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 160gb disk showing up as 137gb
In-Reply-To: <20020426171836.A3160@animx.eu.org>
Message-ID: <Pine.LNX.4.33L2.0204261416040.14014-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002, Wakko Warner wrote:

| Just bought a maxtor 160gb disk and it shows upt as a 137gb disk.  I thought
| this might be the system board's ide chipset limitation so I put a scsi->ide
| adapter on the drive.  Same situation occurs.  I'm looking at what the kernel
| reports when it finds the drive.  /proc/partitions shows this drive as:
|    8     0  134217727 sda
| /proc/scsi/scsi shows:
| Attached devices:
| Host: scsi0 Channel: 00 Id: 00 Lun: 00
|   Vendor: Maxtor 4 Model: G160J8           Rev: GAK8
|   Type:   Direct-Access                    ANSI SCSI revision: 02
|
| I tried kernel 2.4.14 and 2.4.18.  Any ideas?

Hi,

There was a thread on this 2-3 months back.
IDE in 2.4 doesn't have a 48-bit block address interface IIRC,
although Andre has some patches for this.
This is necessary to go above 137 GB.

-- 
~Randy

