Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbRLLAfR>; Tue, 11 Dec 2001 19:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284243AbRLLAfI>; Tue, 11 Dec 2001 19:35:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10253 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284410AbRLLAfB>; Tue, 11 Dec 2001 19:35:01 -0500
Date: Tue, 11 Dec 2001 16:34:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
cc: GOTO Masanori <gotom@debian.org>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>
Subject: Re: [PATCH] direct IO breaks root filesystem
In-Reply-To: <zo4p4742.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Message-ID: <Pine.LNX.4.33.0112111632310.18020-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Dec 2001, Tachino Nobuhiro wrote:
>
>   Your patch will break Goto's fix because mapping->host does not have
> correct i_mode.

Note that Goto's fix really is quite _fundamentally_ broken. Don't use it.

As explained in another email, you really should use the set-block-size
ioctl to set the correct blocksize for the device you are using. That
should work fine once the correct inode is used by the direct_io code..

		Linus

