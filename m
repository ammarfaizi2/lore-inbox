Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSAGTb7>; Mon, 7 Jan 2002 14:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285703AbSAGTbk>; Mon, 7 Jan 2002 14:31:40 -0500
Received: from air-1.osdl.org ([65.201.151.5]:57986 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S285691AbSAGTbh>;
	Mon, 7 Jan 2002 14:31:37 -0500
Date: Mon, 7 Jan 2002 11:33:21 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <200201071904.g07J4Wf02751@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0201071119520.28000-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It still eludes me why a new device FS was developed when devfs
> already has the mechanisms that are needed.

It's really pretty simple, and I don't mean any disrespect by it, so don't
take it personally.

When I started working on this new driver model thingy, I wanted to export
the device tree, so I could individually turn devices on and off. So, I
did it via procfs.

One fine, sunny day, I'm explaining the concept to Linus, and he says
"Don't use proc."

"What do you mean, 'don't use proc'?" (Since I already had done it).

He pointed out that it was old and crufty, and already over-abused. He
suggested that I write my own fs to do it.

So I did. It was easy. I blatantly ripped off ramfs, and it worked.

I looked at devfs for inspiration, but I didn't get very far. It seemed
way too complex for what it was trying to do. And, it was taking too much
frickin' time to figure what the hell you were doing.

Besides, at the time, it was an orthogonal problem. I didn't care about
device class functionality, only the hierarchy.

That's still what I mainly care about. I realized a while back that it
would be relatively simple to add class support. But, I've stayed away
from it for political reasons. I predict there will be an integrated
solution.

Besides, everyone hates devfs. Being the image-conscious guy that I am, I
don't want to play for the team that everyone hates.

Basically, I think I'm just Linus' bitch in this whole scheme of things
for

1) creating a decent /dev replacement
2) helping motivate you to fix devfs
and/or
3) helping motivate people to modernize/fix procfs

He gets what he wants and I take the heat.

I don't really care what gets used. I like my code because I wrote it. It
might suck and be buggy; but I'm willing to fix it, and play by the common
rules. I want something that works and that other people are happy with.

	-pat

