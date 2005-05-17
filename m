Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVEQUno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVEQUno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVEQUno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:43:44 -0400
Received: from alog0315.analogic.com ([208.224.222.91]:58250 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261827AbVEQUnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:43:41 -0400
Date: Tue, 17 May 2005 16:43:18 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: linux@horizon.com
cc: lsorense@csclub.uwaterloo.ca, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Sync option destroys flash!
In-Reply-To: <20050517203117.10588.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.61.0505171638560.10811@chaos.analogic.com>
References: <20050517203117.10588.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005 linux@horizon.com wrote:

>> It can also respond to loosing power during write by getting it's state
>> so mixed up the whole card is dead (it identifies but all sectors fail
>> to read).
>
> Gee, that just happened to me!  Well, actually, thanks to Linux's
> *insistence* on reading the partition table, I haven't managed to
> get I/O errors on anything bit sectors 0 through 7, but I am quite
> sure I wasn't writing those sectors when I pulled the plug:
>
> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
> ide0: reset: success
> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
> end_request: I/O error, dev 03:00 (hda), sector 6
> unable to read partition table
[SNIPPED...]

You can "fix" this by writing all sectors. Although the data is lost,
the flash-RAM isn't. This can (read will) happen if you pull the
flash-RAM out of its socket with the power ON.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
