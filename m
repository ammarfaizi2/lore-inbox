Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130198AbQLHXRk>; Fri, 8 Dec 2000 18:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132173AbQLHXRb>; Fri, 8 Dec 2000 18:17:31 -0500
Received: from hera.cwi.nl ([192.16.191.1]:34022 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130198AbQLHXRR>;
	Fri, 8 Dec 2000 18:17:17 -0500
Date: Fri, 8 Dec 2000 23:46:39 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Matan Ziv-Av <matan@svgalib.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Big IDE HD unclipping and IBM drive
Message-ID: <20001208234639.A538@veritas.com>
In-Reply-To: <Pine.LNX.4.21_heb2.09.0012082319530.962-100000@matan.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21_heb2.09.0012082319530.962-100000@matan.home>; from matan@svgalib.org on Fri, Dec 08, 2000 at 11:24:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 11:24:56PM +0200, Matan Ziv-Av wrote:

> I have an IBM drive, DTLA-307075 (75GB), and a bios that hangs with
> large disks. I use a jumper to clip it to 32GB size, so the bios can
> boot into linux. The problem is that WIN_READ_NATIVE_MAX returns 32GB,
> and not the true size, and even trying to set the correct size with
> WIN_SET_MAX fails. Is there a way to use this combination (Bios, HD,
> Linux)?

Don't know where you found WIN_READ_NATIVE_MAX,
or what program you tried in order to fiddle with
these things. The ATA standard calls the command
READ NATIVE MAX ADDRESS.

So far I have seen success with READ_NATIVE_MAX_ADDRESS
and SET_MAX_ADDRESS on Maxtor drives but do not offhand
recall any reports on IBM DTLA drives.
(Posted a few times a setmax.c utility that you can try.)

You can also try to contact IBM support.
Files like dtla_spw.pdf only mention that you can clip capacity
using a jumper, but there is no hint that it would be
possible to unclip using SET_MAX_ADDRESS.

Be careful that you do not lock the disk.
(The command only functions as a SET_MAX_ADDRESS when
immediately preceded by a READ_NATIVE_MAX_ADDRESS.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
