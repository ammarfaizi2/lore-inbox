Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271627AbRHUKEt>; Tue, 21 Aug 2001 06:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271629AbRHUKEj>; Tue, 21 Aug 2001 06:04:39 -0400
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:12815 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S271627AbRHUKEX>; Tue, 21 Aug 2001 06:04:23 -0400
Date: Tue, 21 Aug 2001 11:03:29 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Doug McNaught <doug@wireboard.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <3B812FD2.836572F5@nortelnetworks.com>
Message-ID: <Pine.LNX.4.21.0108211049520.6695-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Chris Friesen wrote:

> The main reason for my comment was the suggestion by Steve Hill that
> /dev/urandom was NOT cryptographically secure.  Re-reading it, his comment was
> in the context of generating cryptographic keys, so perhaps I misunderstood what
> he meant.

Sorry - I'm not a cryptography expert, just your average Linux hacker :)

I was under the impression that urandom was considered insecure (hence why
it is not used by ssh, FreeS/WAN, etc), and so was very dubious about just
linking /dev/random to /dev/urandom.  However I still had the problem that
being a headless system, there wasn't much entropy (something which had
never been a problem under Cobalt's kernels - presumably they had kludged
/dev/random on the kernel-side).

After various suggestions, and a correction (I now understand urandom to
be secure despite the very theoretical vulnerability), I opted to get
extra entropy from the eepro100 and natsemi network devices.

Anyway, I would consider that the idea of generating entropy purely from
the local console (keyboard / mouse) to be a rather flawed idea - think
how many headless linux servers there are that are running some kind of
cryptographic software.  Maybe a compile-time option in the kernel to
change quality of /dev/random would be an idea so that the person
compiling the kernel can decide on the level of the tradeoff between the
quality and speed/amount of randomness...  Just a thought anyway.

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


