Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279904AbRKNA4k>; Tue, 13 Nov 2001 19:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279907AbRKNA4b>; Tue, 13 Nov 2001 19:56:31 -0500
Received: from modem-1461.leopard.dialup.pol.co.uk ([217.135.149.181]:10514
	"EHLO Mail.MemAlpha.cx") by vger.kernel.org with ESMTP
	id <S279904AbRKNA4W>; Tue, 13 Nov 2001 19:56:22 -0500
Posted-Date: Wed, 14 Nov 2001 00:45:20 GMT
Date: Wed, 14 Nov 2001 00:45:19 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Rob Turk <r.turk@chello.nl>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: scsi_scan.c: emulate windows behavior
In-Reply-To: <9srtm6$8hf$1@ncc1701.cistron.net>
Message-ID: <Pine.LNX.4.21.0111140042000.3058-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob.

> Getting more than 36 bytes should not be a problem for any device.
> The root problem seems to be that 255 is an odd number. On
> Wide-SCSI, a lot of devices have difficulty handling odd byte counts
> as they have to use additional messaging to flag the residue in the
> last 16-bit transfer. Also, the IDE-SCSI layer has trouble, as the
> IDE spec doesn't allow odd byte transfers at all. I've experienced
> issues with IDE devices that had to have their firmware patched just
> to deal with the Linux odd-byte request.

> Maybe a better change would be to use 64 or 128 byte requests. Your
> thoughts?

Probably the best option would be to tweak this to 256 if that is
available, or 252 if not - I seem to remember there's at least one
SCSI drive that can't handle other than multiples of 4 bytes.

Best wishes from Riley.

