Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbTAROVR>; Sat, 18 Jan 2003 09:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbTAROVR>; Sat, 18 Jan 2003 09:21:17 -0500
Received: from [81.2.122.30] ([81.2.122.30]:37637 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264799AbTAROVQ>;
	Sat, 18 Jan 2003 09:21:16 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301181430.h0IEUK6D001055@darkstar.example.net>
Subject: Re: reading from devices in RAW mode
To: folkert@vanheusden.com (Folkert van Heusden)
Date: Sat, 18 Jan 2003 14:30:20 +0000 (GMT)
Cc: szepe@pinerecords.com, linux-kernel@vger.kernel.org
In-Reply-To: <003001c2bef9$fa08cc90$3640a8c0@boemboem> from "Folkert van Heusden" at Jan 18, 2003 03:00:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it such a newby question? Your suggestion of using dd is totally NOT
> what I meant: I want to read from devices with the devices ignoring their
> CRC-checks and such. Like what the CDROMREADRAW ioctl does for CD-ROMs.

CD-ROMs, floppy disks, and hard disks work in completely different
ways:

All modern forms of storage use powerful error correction below the
sector level.  Floppies are the exception here, they typically use MFM
encoding, which is relatively straightforward.

Audio Compact discs use powerful error correction anyway, but CD-ROMs
use some of the capacity which was previously used for audio data for
a second level of error correction, so there are two sector sizes,
(RAW, and COOKED).  Reading RAW sectors, does not come close to
allowing you to read individual pits and flats on the disc, it just
lets you bypass the top level of error correction.  The data is still
being error corrected by lower layers.

There is no floppy or hard disk equivillent to reading raw sectors
from CD-ROMs.

John.
