Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281805AbRKQS6r>; Sat, 17 Nov 2001 13:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281807AbRKQS6h>; Sat, 17 Nov 2001 13:58:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45068 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281805AbRKQS6Y>; Sat, 17 Nov 2001 13:58:24 -0500
Date: Sat, 17 Nov 2001 10:53:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <wwcopt@optonline.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Re: 2.4.15-pre5: /proc/cpuinfo broken
In-Reply-To: <Pine.GSO.4.21.0111171250310.11475-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111171052060.1458-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Nov 2001, Alexander Viro wrote:
>
> Frankly, I'd prefer to try (b) before reverting to (a).  Patch doing that
> variant follows.  Linus, your opinion?

(d) make seq_file have my originally suggested "subposition" code.

Ie make the X low bits of "pos" be the position in the record, with the
high bits of "pos" being the current "record index" kind of thing.

That makes lseek() happy.

		Linus

