Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267876AbTAHUYc>; Wed, 8 Jan 2003 15:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267877AbTAHUYc>; Wed, 8 Jan 2003 15:24:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61706 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267876AbTAHUYa>; Wed, 8 Jan 2003 15:24:30 -0500
Date: Wed, 8 Jan 2003 12:28:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Levon <levon@movementarian.org>
cc: linux-kernel@vger.kernel.org, <davem@redhat.com>
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
In-Reply-To: <20030108195934.GA35912@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0301081222430.5369-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Jan 2003, John Levon wrote:
> 
> OProfile needs to know the pointer size being used for the kernel,
> on platforms with 32-bit userspace and 64-bit kernel. This patch adds
> a simple ro sysctl that exports this information as suggested by davem

No. 

This is the kind of stupid bloat I do not want. The kernel pointer size
doesn't change suddenly on the machine, there's no point at all in doing
something like this and exporting it through proc, when the information is
perfectly available in other ways or could even be a user program config
file option.

There is _no_ excuse for a program asking for what the kernel pointer size 
is. Adding a random /proc file just because it's easy is not a good idea. 
Bloat is bloat, and 99% of all bloat comes one little feature at a time.

Quite frankly, just compile oprofile for the architecture and be done with 
it. Or add a command line option. Don't add stupid bloat to the kernel 
because somebody is silly enough to care about a 32-bit oprofile working 
with a 64-bit kernel. 

		Linus

