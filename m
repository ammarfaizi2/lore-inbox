Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311797AbSCNV0B>; Thu, 14 Mar 2002 16:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311798AbSCNVZt>; Thu, 14 Mar 2002 16:25:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38661 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311797AbSCNVZk>; Thu, 14 Mar 2002 16:25:40 -0500
Date: Thu, 14 Mar 2002 13:24:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Heil <kerndev@sc-software.com>
cc: <linux-kernel@vger.kernel.org>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <Pine.LNX.4.33.0203141234170.1286-100000@scsoftware.sc-software.com>
Message-ID: <Pine.LNX.4.33.0203141318130.9855-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Mar 2002, John Heil wrote:
> 
> No, the better/correct port is 0xED which removes the conflict.

Port ED is fine for a BIOS, which (by definition) knows what the
motherboard devices are, and thus knows that ED cannot be used by
anything.

But it _is_ an unused port, and that's exactly the kind of thing that
might be used sometime in the future. Remember the port 22/23 brouhaha
with Cyrix using it for their stuff, and later Intel getting into the fray
too?

So the fact that ED works doesn't mean that _stays_ working.

The fact that 80 is the post code register means that it is fairly likely 
to _stay_ that way, without any ugly surprises.

Now, if there is something _else_ than just the fact that it is unused
that makes ED a good choice in the future too, that might be worth looking
into (like NT using it for the same purpose as Linux does port 80),

		Linus

