Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310145AbSCFUHm>; Wed, 6 Mar 2002 15:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310154AbSCFUHc>; Wed, 6 Mar 2002 15:07:32 -0500
Received: from www.transvirtual.com ([206.14.214.140]:59396 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S310145AbSCFUHW>; Wed, 6 Mar 2002 15:07:22 -0500
Date: Wed, 6 Mar 2002 12:07:14 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  March 6, 2002
In-Reply-To: <20020306201646.J14098@suse.de>
Message-ID: <Pine.LNX.4.10.10203061124050.12924-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > > o Alpha       Rewrite of the framebuffer layer                (James Simmons)
>  > > o Started     Rewrite of the console layer                    (James Simmons)
>  > Since this is in -dj and people are using it, maybe it should be beta?
> 
>  It's stable enough that at least bits of it should probably start
>  being pushed to Linus soon. This and the input layer changes probably
>  make up for quite a high percentage of my current diff.

The input stuff should again be synced. The only thing I like to see is
the creation of a touchscreen and others directory in drivers/input. We
had this discussion on the ARM list this morning. 

As for the framebuffer stuff that can also be synced for the most part.
At present I'm working on new soft accels to replace that fbcon-cfb* mess.
The one thing missing is a universal cursor api. I purposed one but
nothing happened. Its not urgent yet anyways.

Now the console stuff needs more work. That shouldn't go in yet. The
changes break things else where. The changes that affect people are
struct kbd_struct[] is gone. Also a few of the ioctl32.c files get
broken. The next big thing is the removal of fg_console but this will
break alot of keyboard drivers. Which again I push for people to move
their keyboard drivers over to the input api.





