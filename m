Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279782AbRKFQIe>; Tue, 6 Nov 2001 11:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279243AbRKFQIY>; Tue, 6 Nov 2001 11:08:24 -0500
Received: from ns.ithnet.com ([217.64.64.10]:50693 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S279785AbRKFQIL>;
	Tue, 6 Nov 2001 11:08:11 -0500
Date: Tue, 6 Nov 2001 17:05:41 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: marcelo@conectiva.com.br, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: out_of_memory() heuristic broken for different mem configurations
Message-Id: <20011106170541.7c06a383.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0111060714070.1988-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0111060928010.9782-100000@freak.distro.conectiva>
	<Pine.LNX.4.33.0111060714070.1988-100000@penguin.transmeta.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001 07:25:40 -0800 (PST) Linus Torvalds <torvalds@transmeta.com>
wrote:

> Note how you also go for seconds with no IO and no shrinking of the
> caches, while shrink_cache() is apparently happy (and no, it does not take
> several seconds to traverse even a 16GB inactive queue, there's something
> else going on)

Did you time it? There is a lot of things going on in the shrink_cache loop
including swap_out, wait_on_page, locks, ...
It's not really simple traversing of a queue.

