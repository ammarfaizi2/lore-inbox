Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbTEFHvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTEFHvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:51:07 -0400
Received: from [217.157.19.70] ([217.157.19.70]:525 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S262442AbTEFHvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:51:06 -0400
Date: Tue, 6 May 2003 10:03:37 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Adam Sulmicki <adam@cfar.umd.edu>
cc: Halil Demirezen <nitrium@bilmuh.ege.edu.tr>,
       <linux-kernel@vger.kernel.org>
Subject: Re: about bios
In-Reply-To: <20030505193733.T76699-100000@www.missl.cs.umd.edu>
Message-ID: <Pine.LNX.4.40.0305060946450.8287-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003, Adam Sulmicki wrote:

> 'was working'? The project is alive and well.

Sorry, didn't mean it as "the project is now dead", just "been a while
since I checked its status" :-)

>[..]
> By the way. Yes you can burn the linux kernel into flash (together with
> linuxBIOS) and boot it this way. But given that many motherboards limit
> your flash size to 256KiB you probably want to put the kernel on the
> CompactFlash over ide nevertheless. Interestingly enough if not this size
> limit we might have ended up using Linux Kernel as hardware initalizator
> to some degree.

A couple of years ago I was doing a Linux port to a MIPS based embedded
system, and while we did set up the SDRAM controller, chip select timings
etc. in the flash bootloader, most of these were settings overwritten
again by the kernel (that way, a kernel would work with any version of the
bootloader, and the bootloader would not have to be updated if something
had to be changed or a timing improved for performance).

This approach seems to me to make sense, and it would be interesting if
the kernel would include direct support for various chipsets and
(optional?) code to set them up from scratch (or almost, e.g. SDRAM
working but not much else), that way a truly minimal BIOS stub could be
used and the kernel could provide interfaces to tune the chipsets in
various ways.

That would probably mean the limit on kernel command line length would
have to be dropped (if it hasn't already) to allow for things like
"sis_enable_fdc=1"  (to get back to the original question), but it would
certainly be flexible on the chipsets that were supported.

// Thomas


