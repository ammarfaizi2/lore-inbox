Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130647AbRCFNPz>; Tue, 6 Mar 2001 08:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130651AbRCFNPq>; Tue, 6 Mar 2001 08:15:46 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:19965 "EHLO
	imladris.rielhome.conectiva") by vger.kernel.org with ESMTP
	id <S130647AbRCFNPd>; Tue, 6 Mar 2001 08:15:33 -0500
Date: Tue, 6 Mar 2001 09:22:02 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <l0313030ab6ca4912a397@[192.168.239.101]>
Message-ID: <Pine.LNX.4.21.0103060920320.5591-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Jonathan Morton wrote:

> Pathological shutdown pattern:  assuming scatter-gather is not allowed (for
> IDE), and a 20ms full-stroke seek, write sectors at alternately opposite
> ends of the disk, working inwards until the buffer is full.  512-byte
> sectors, 2MB of them, is 4000 writes * 20ms = around 80 seconds (not
> including rotational delay, either).  Last time I checked, you'd need a
> capacitor array the size of the entire computer case to store enough power
> to allow the drive to do this after system shutdown, and I don't remember
> seeing LiIon batteries strapped to the bottom of my HDs.  Admittedly, any
> sane OS doesn't actually use that kind of write pattern on shutdown, but
> the drive can't assume that.

But since the drive has everything in cache, it can just write
out both bunches of sectors in an order which minimises disk
seek time ...

(yes, the drives don't guarantee write ordering either, but that
shouldn't come as a big surprise when they don't guarantee that
data makes it to disk ;))

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

