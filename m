Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143845AbRAHOJW>; Mon, 8 Jan 2001 09:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143932AbRAHOJM>; Mon, 8 Jan 2001 09:09:12 -0500
Received: from zeus.kernel.org ([209.10.41.242]:24037 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S143845AbRAHOJH>;
	Mon, 8 Jan 2001 09:09:07 -0500
Date: Mon, 8 Jan 2001 09:21:06 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: "David S. Miller" <davem@redhat.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Delay in authentication.
In-Reply-To: <200101081331.FAA18576@pizda.ninka.net>
Message-ID: <Pine.LNX.4.31.0101080918260.17858-100000@rc.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, David S. Miller wrote:

> This definitely seems like the classic "/etc/nsswitch.conf is told to
> look for YP servers and you are not using YP", so have a look and fix
> nsswitch.conf if this is in fact the problem.

What I have never gotten, is why on my machines (no specific distro, just
everything built from source and installed by me) login takes a long time,
unless I have portmap running.

My /etc/nsswitch.conf would seem to be right:

passwd:         files
group:          files
shadow:         files

hosts:          files dns
networks:       files dns

protocols:      files
services:       files
ethers:         files
rpc:            files

netgroup:       files

What else could effect that?

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
