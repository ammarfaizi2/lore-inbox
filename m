Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUBRNfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266780AbUBRNfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:35:22 -0500
Received: from mx.eastlink.ca ([24.222.0.20]:27406 "EHLO mx.eastlink.ca")
	by vger.kernel.org with ESMTP id S266545AbUBRNfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:35:13 -0500
Date: Wed, 18 Feb 2004 09:30:11 -0400 (AST)
From: Steve Bromwich <kernel@fop.ns.ca>
Subject: Re: harddisk or kernel problem?
In-reply-to: <20040215233441.GJ1881@schottelius.org>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.58.0402180921120.7046@brain.fop.ns.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040213075403.GC1881@schottelius.org>
 <20040213081104.GD1881@schottelius.org>
 <20040213095223.GE1881@schottelius.org>
 <200402131717.34917.bzolnier@elka.pw.edu.pl>
 <20040215233441.GJ1881@schottelius.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004, Nico Schottelius wrote:

> Bartlomiej Zolnierkiewicz [Fri, Feb 13, 2004 at 05:17:34PM +0100]:
> I'm really down as this is the second disk
> dyeing within two month (and the second 2.5" hd even, I begin to think
> notebooks don't like me :/).
>
> I currently collect all data I get / find out to
>
> http://schotteli.us/~nico/hd-problem.02/

194 Temperature_Celsius     0x0022   100   050   000    Old_age   Always
-       48 (Lifetime Min/Max 14/65)

If I'm reading this correctly, you've been running the drive when it's
extremely cold and extremely hot (Min/Max 14/65, I'm guessing that's
either Fahrenheit or a raw unconverted reading from the thermistor). I
managed to completely hork a notebook drive after leaving my laptop in the
boot of my car for several hours (~-25C), taking it into a warm apartment
(~19C), booting it up and lifting the notebook off my lap sideways whilst
I shifted to get comfortable and putting it back on my lap. The hard drive
had a head crash (I think) on the sectors it was reading while I moved and
the partition was effectively toast - this was my Debian partition, and
wouldn't boot any more, but I could boot off the RedHat partition and
/home was (thankfully) still readable. I pulled all the data off in
preparation for the drive failing before I could get a new one (I was down
in Boston at the time), but the bad sectors slowly spread through the
entire drive over the course of a couple of days and I couldn't read any
data at all.

Lessons learned:

* Let laptops settle to room temperature after being exposed to sub-zero
temperatures for a while (this is probably in the manual, but I don't have
one)

* Laptop notebooks may be somewhat ruggedised but they still don't like
being moved when they're reading off the drive.

Running drives really hot is also a good way to toast them, too!

Cheers, Steve
