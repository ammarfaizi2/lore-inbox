Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285200AbRLFUy4>; Thu, 6 Dec 2001 15:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285196AbRLFUxX>; Thu, 6 Dec 2001 15:53:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8970 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285191AbRLFUwi>; Thu, 6 Dec 2001 15:52:38 -0500
Date: Thu, 6 Dec 2001 12:46:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <8EK0gp-1w-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.33.0112061243130.10877-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Dec 2001, Kai Henningsen wrote:
>
> Frankly, format should really have NO timeout. Or possibly a user-
> specified one.

Well, frankly, the interface should be that the user code sends the
command it needs, and waits for it. With no policy in the kernel at all.

Now, for backwards compatibility reasons we cannot do that generically,
and some things (not format, though), may be common enough that the
"library code" to do the normal thing is in the kernel. But on the whole,
the question should not be "how long should the timeout be", but more
along the lines of "how can we make this easy to interface to existing and
new applications _without_ having policy decisions like timeouts and
number of retries".

		Linus

