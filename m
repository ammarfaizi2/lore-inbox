Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbSKPS0k>; Sat, 16 Nov 2002 13:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbSKPS0k>; Sat, 16 Nov 2002 13:26:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56326 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267329AbSKPS0j>; Sat, 16 Nov 2002 13:26:39 -0500
Date: Sat, 16 Nov 2002 10:33:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb
In-Reply-To: <20021116182454.GH19061@waste.org>
Message-ID: <Pine.LNX.4.44.0211161025500.15838-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Nov 2002, Oliver Xymoron wrote:
> 
> LAN latencies should be low enough that waiting on an ACK for each
> packet will do just fine for error correction. If someone wants to do
> remote debugging, they can ssh into a debugging machine on the same LAN.

I agree in theory on a technical level, yet at the same time it's clearly
advantageous _not_ to wait, since it would allow you to just universally
enable the LAN as the console on all your machines when you maintain them,
and then not have that LAN console be a maintenance problem.

Basically, I don't personally care too much for kgdb itself, but I see a
asynchronous LAN console as a more generic tool for just doing not just
kernel debugging, but management in general. syslogd is fine for when the
machines work, but it tends to lose important information just when you
need it the most, ie when a machine starts having serious problems.

So if you see the LAN interface more as a simple console (that _also_ 
gives you access to kgdb), then it's a whole lot more usable for much more 
than just kernel hacking.

A synchronous interface would make logging basically useless - it would 
basically crash the machine if there are logger problems, and it would 
make log output slow things down a lot.

			Linus

