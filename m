Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285022AbRLLBwK>; Tue, 11 Dec 2001 20:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285051AbRLLBwA>; Tue, 11 Dec 2001 20:52:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1040 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285022AbRLLBvp>; Tue, 11 Dec 2001 20:51:45 -0500
Date: Tue, 11 Dec 2001 17:46:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
cc: GOTO Masanori <gotom@debian.org>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>
Subject: Re: [PATCH] direct IO breaks root filesystem
In-Reply-To: <y9k945x1.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Message-ID: <Pine.LNX.4.33.0112111742001.18126-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Dec 2001, Tachino Nobuhiro wrote:
>
> But my patch fixes another bug. Current /dev/ram* does not return -ENOSPC
> at the end of device size because generic_file_write() also checks whether
> mapping->host is a block device. So I think the patch is required.

I'll agree with your one-liner: it's good practice anyway to initialize
any fields that could ever be looked at. I actually already applied it to
my tree, I just want to make sure that people don't apply the other
patch..

		Linus

