Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbRATWiV>; Sat, 20 Jan 2001 17:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbRATWiL>; Sat, 20 Jan 2001 17:38:11 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:14303 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S130113AbRATWiC>; Sat, 20 Jan 2001 17:38:02 -0500
Date: Sat, 20 Jan 2001 23:24:02 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101201247330.10602-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10101202252380.13864-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 20 Jan 2001, Linus Torvalds wrote:

> But point-to-point also means that you don't get any real advantage from
> doing things like device-to-device DMA. Because the links are
> asynchronous, you need buffers in between them anyway, and there is no
> bandwidth advantage of not going through the hub if the topology is a
> pretty normal "star" kind of thing. And you _do_ want the star topology,
> because in the end most of the bandwidth you want concentrated at the
> point that uses it.

I agree, but who says, that the buffer always has to be the main memory?
That might be true especially for embedded devices. The cpu is then just
the local controller, that manages several devices with its own buffer.
Let's take a file server with multiple disks and multiple network cards
with it's own buffer. For stuff like this you don't want to go through the
main memory, on the other hand you still need to synchronize all the data.
Although I don't know such hardware, but I don't see a reason not to do it
under Linux. :-)

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
