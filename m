Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTAGAHk>; Mon, 6 Jan 2003 19:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267207AbTAGAHk>; Mon, 6 Jan 2003 19:07:40 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:43790 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267190AbTAGAHi>; Mon, 6 Jan 2003 19:07:38 -0500
Message-ID: <3E19B401.7A9E47D5@linux-m68k.org>
Date: Mon, 06 Jan 2003 17:51:13 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@pyxtechnologies.com>
CC: Oliver Xymoron <oxymoron@waste.org>, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>, Richard Stallman <rms@gnu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> If you know anything about iSCSI RFC draft and how storage truly works.
> Cisco gets it wrong, they do not believe in supporting the full RFC.
> So you get ERL=0, and now they turned of the "Header and Data Digests",
> this is equal to turning off the iCRC in ATA, or CRC in SCSI between the
> controller and the device.  For those people who think removing the
> checksum test for the integrity of the data and command operations, you
> get what you deserve.

Ever heard of TCP checksums? Ever heard of ethernet checksums? Which
transport doesn't use checksums nowadays? The digest makes only sense if
you can generate it for free in hardware or for debugging, otherwise
it's only a waste of cpu time. This makes the complete ERL 1 irrelevant
for a software implementation. With block devices you can even get away
with just ERL 0 to implement transparent recovery.

bye, Roman

