Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbTCOJMa>; Sat, 15 Mar 2003 04:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbTCOJMa>; Sat, 15 Mar 2003 04:12:30 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:6607 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S261360AbTCOJM1>; Sat, 15 Mar 2003 04:12:27 -0500
Date: Sat, 15 Mar 2003 10:23:16 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash dumping
Message-ID: <20030315092316.GA23553@wohnheim.fh-wedel.de>
References: <200303150846.h2F8k6IX000895@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200303150846.h2F8k6IX000895@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 March 2003 08:46:06 +0000, John Bradford wrote:
> 
> Just wondering, we've had a lot of discussions in the past about
> various serial port/network/disk crash dumping ideas, and always had
> the problem of how do we know that the code we're about the execute
> hasn't been corrupted, etc, which is especially important in the case
> of the disk dumper.
> 
> Well, with the Linux BIOS project, couldn't we include some code in
> the BIOS that we can jump to after a kernel crash, I.E. just switch to
> real mode and start executing the BIOS-contained code to put the
> system in to a sane state, and accept commands over the network[1] via
> either UDP, or a custom protocol, to dump memory to disk, network, or
> whatever?

I still have the wacky plan to write a simple crash dumper in
assembler. Goal is to code it up in less than 4k of memory, put a
checksum check in it to ensure clean code and dump to ide, but
anything else is fine as well.

The easy parts are already finished. :) But now it's time to look up
the hardware manuals and I got distracted.

Should be quite similar to the BIOS idea, even nearly as safe. As long
as the code path to jump into the (BIOS) dump code is intact, chances
are good that 4k of memory somewhere are intact as well.

Jörn

-- 
It's just what we asked for, but not what we want!
-- anonymous
