Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbTARPyo>; Sat, 18 Jan 2003 10:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbTARPyn>; Sat, 18 Jan 2003 10:54:43 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:384 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S264863AbTARPyn>; Sat, 18 Jan 2003 10:54:43 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'John Bradford'" <john@grabjohn.com>
Cc: <szepe@pinerecords.com>, <linux-kernel@vger.kernel.org>
Subject: RE: reading from devices in RAW mode
Date: Sat, 18 Jan 2003 17:03:39 +0100
Message-ID: <003501c2bf0b$2ae93ff0$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200301181430.h0IEUK6D001055@darkstar.example.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is it such a newby question? Your suggestion of using dd is totally NOT
> > what I meant: I want to read from devices with the devices ignoring
their
> > CRC-checks and such. Like what the CDROMREADRAW ioctl does for CD-ROMs.
> CD-ROMs, floppy disks, and hard disks work in completely different
> ways:
> All modern forms of storage use powerful error correction below the
> sector level.  Floppies are the exception here, they typically use MFM
> encoding, which is relatively straightforward.
> Audio Compact discs use powerful error correction anyway, but CD-ROMs
> use some of the capacity which was previously used for audio data for
> a second level of error correction, so there are two sector sizes,
> (RAW, and COOKED).  Reading RAW sectors, does not come close to
> allowing you to read individual pits and flats on the disc, it just
> lets you bypass the top level of error correction.  The data is still
> being error corrected by lower layers.

oh, ok. But I will still get more data back then with reading through
the regular, say, /dev/hdc-device wouldn't I? As far as I know, read
will only give you data when no I/O error occured.

> There is no floppy or hard disk equivillent to reading raw sectors
> from CD-ROMs.

Really? Are you really sure about that?

Back in the old days, when I did assembly on my Atari ST, I would just
say to the controller "gimme this and that track, in RAW" and it
would do so. I thought that I could do that at least for floppy, not
sure about harddisk (RLL through ACSI interface).

