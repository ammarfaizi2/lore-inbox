Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144277AbRAHP5q>; Mon, 8 Jan 2001 10:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144290AbRAHP5l>; Mon, 8 Jan 2001 10:57:41 -0500
Received: from zeus.kernel.org ([209.10.41.242]:56288 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S144277AbRAHP50>;
	Mon, 8 Jan 2001 10:57:26 -0500
Date: Mon, 8 Jan 2001 11:09:26 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: Igmar Palsenberg <maillist@chello.nl>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Delay in authentication.
In-Reply-To: <Pine.LNX.4.21.0101081725250.10084-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.4.31.0101081043160.17858-100000@rc.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Igmar Palsenberg wrote:

> check /etc/pam.d/login

No pam.

> Could be kerberos that is biting you, althrough that doesn't explain the
> portmap story.

So no kerberos.

I just rebuilt the shadow suite (where my login comes from) to be on the
safe side.  But the problem is still there.

ldd login shows:
        libshadow.so.0 => /lib/libshadow.so.0 (0x4001a000)
        libcrypt.so.1 => /lib/libcrypt.so.1 (0x40033000)
        libc.so.6 => /lib/libc.so.6 (0x40060000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

I'm running glibc-2.2, but this problem also existed in 2.1.x (which I had
installed when I went to the 2.3 kernels that exposed this problem).

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
