Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbRARQY4>; Thu, 18 Jan 2001 11:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130361AbRARQYq>; Thu, 18 Jan 2001 11:24:46 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:22533 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130077AbRARQYf>; Thu, 18 Jan 2001 11:24:35 -0500
Date: Thu, 18 Jan 2001 08:24:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <200101181001.f0IA11I25258@webber.adilger.net>
Message-ID: <Pine.LNX.4.10.10101180822020.18072-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jan 2001, Andreas Dilger wrote:
> 
> Actually, this is a great example, because at one point I was working
> on a device interface which would offload all of the disk-disk copying
> overhead to the disks themselves, and not involve the CPU/RAM at all.

It's a horrible example.

device-to-device copies sound like the ultimate thing. 

They suck. They add a lot of complexity and do not work in general. And,
if your "normal" usage pattern really is to just move the data without
even looking at it, then you have to ask yourself whether you're doing
something worthwhile in the first place.

Not going to happen.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
