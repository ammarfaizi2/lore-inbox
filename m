Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273578AbRIYU5P>; Tue, 25 Sep 2001 16:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRIYU4y>; Tue, 25 Sep 2001 16:56:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:24961 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S273564AbRIYU4t>; Tue, 25 Sep 2001 16:56:49 -0400
Date: Tue, 25 Sep 2001 16:57:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet Error Correction
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.95.1010925164155.11921A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Karel Kulhavy wrote:

> What about implementing an Ethernet error correction in Linux kernel?
> 

Ethernet uses hardware error detection. Only good packets get through.
Therefore there is nothing that a driver in the kernel could do to
recover an otherwise errored packet because the packet doesn't exist.

> Does exist any standard that would normalize ethernet error correction? The
> situation is basically this:
>

As stated, there is no "error correction" on ethernet. Only detection
exists. The ethernet packet consists of a sync preamble, the destination
address, the source address, a packet length, some data, then a CRC.

If the hardware CRC doesn't match, the packet is dropped by hardware.

TCP/IP and other actual network stuff goes in the "data" area.

 
> Let's say I have two PC's, with ethernet NIC's. An atmospherical optical link
> (full duplex) is between them, connected via AUI. The optics goes crazy when
> there is a fog of course. But dropping a single bit in 1500 bytes makes a lot
> of mess.  There is also unsused src and dest address (12 bytes) which is
> obvious and superfluous.  What about kicking the address off and putting some
>
[SNIPPED...]

If ethernet is being used for the optical link, it's only because such
boards are cheap and drivers exist.

An optical link, built from scratch, uses the same transceivers used
for fiber. They don't use Ethernet. Then use TAXI and/or other
self-clocking serial protocols.

A PPP link doesn't use source and destination addresses as does
Ethernet. You could make a serial driver for your IR link and
use PPP on both ends to communicate. The PPP overhead is quite
low. Your link will be as fast as the underlying hardware.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


