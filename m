Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSFISeQ>; Sun, 9 Jun 2002 14:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSFISeP>; Sun, 9 Jun 2002 14:34:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45316 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314433AbSFISeP>; Sun, 9 Jun 2002 14:34:15 -0400
Date: Sun, 9 Jun 2002 11:33:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
cc: Kai Henningsen <kaih@khms.westfalen.de>, <linux-kernel@vger.kernel.org>
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
In-Reply-To: <20020609182224.GE1078@gallifrey>
Message-ID: <Pine.LNX.4.44.0206091130490.13751-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jun 2002, Dr. David Alan Gilbert wrote:
>
> Personally I would do away with ifconfig and replace it with
> cat in and out of device nodes; ifconfig seems to suffer about having to
> know about every protocol on every device type and the kernel has to
> provide interfaces for it that only it uses.

Well, the kernel would have to provide the same interfaces for "cat" if
you did it that way, and it would probably take up more space and cause
more kernel bloat.

And we'd still have to have the old interfaces for backwards compatibility
for ifconfig.

Is the "magic ioctl" approach ugly? Sure. But it's fairly well contained
to just one program (ifconfig), and everybody else just uses that. I think
it's less horrible than the alternatives right now.

		Linus

