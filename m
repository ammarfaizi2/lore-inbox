Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAHWPw>; Mon, 8 Jan 2001 17:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbRAHWPc>; Mon, 8 Jan 2001 17:15:32 -0500
Received: from anime.net ([63.172.78.150]:43532 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129742AbRAHWPZ>;
	Mon, 8 Jan 2001 17:15:25 -0500
Date: Mon, 8 Jan 2001 14:16:05 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Russell King <rmk@arm.linux.org.uk>
cc: Michael Meissner <meissner@spectacle-pond.org>, Ookhoi <ookhoi@dds.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The advantage of modules?
In-Reply-To: <200101082150.f08Lots13085@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0101081414020.19299-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Russell King wrote:
> > so my take is unless you explicitly use hotplug devices (I wasn't), that
> > it is much safer to unload the driver, unattach/attach scsi devices, and
> > then reload the driver (which will scan the scsi bus for devices), which
> > you need modules for.
> I don't believe that is what it's trying to say.  There have been instances
> in the past where unplugging a SCSI device from a powered on SCSI bus can
> result in blown terminator power fuses and the like.  Whether this still
> applies today, I don't know (are active terminators better or worse than
> passive when it comes to this type of thing?)

The term SCSI is depreciated as purely a physical layer. We talk SCSI over
many different physical layers (1394, usb, ata). Of course many of these
support hot plug natively.

You can get hotplug adapters for ata devices now. Can linux handle them?

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
