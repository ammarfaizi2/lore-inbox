Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262958AbREWCll>; Tue, 22 May 2001 22:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262957AbREWClb>; Tue, 22 May 2001 22:41:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:29446 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262956AbREWClR>; Tue, 22 May 2001 22:41:17 -0400
Date: Tue, 22 May 2001 19:40:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, viro@math.psu.edu, axboe@suse.de
Subject: Re: [PATCH] struct char_device
In-Reply-To: <3B0AFE0C.8392E7C4@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0105221938080.4713-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 May 2001, Jeff Garzik wrote:
>
> IMHO it would be nice to (for 2.4) create wrappers for accessing the
> block arrays, so that we can more easily dispose of the arrays when 2.5
> rolls around...

No.

We do not create wrappers "so that we can easily change the implementation
when xxx happens".

That way lies bad implementations.

We do the _good_ implementation first, and then we create the
"kcompat-2.4" file later that makes people able to use the good
implementation.

Why this way? Because wrapping for wrappings sake just makes code
unreadable (see acpi), and often makes it less obvious what you actually
_have_ to do, and what you don't. So get the design right _first_, and
once the design is right, _then_ you worry about kcompat-2.4.

		Linus

