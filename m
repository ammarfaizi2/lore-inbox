Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSJ2GID>; Tue, 29 Oct 2002 01:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261608AbSJ2GIC>; Tue, 29 Oct 2002 01:08:02 -0500
Received: from air-2.osdl.org ([65.172.181.6]:37531 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261609AbSJ2GIB>;
	Tue, 29 Oct 2002 01:08:01 -0500
Date: Mon, 28 Oct 2002 22:10:39 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andrea Arcangeli <andrea@suse.de>
cc: <chrisl@vmware.com>, Christoph Rohland <cr@sap.com>,
       Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <chrisl@gnuchina.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
In-Reply-To: <20021028192214.GI13972@dualathlon.random>
Message-ID: <Pine.LNX.4.33L2.0210282204030.13622-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Andrea Arcangeli wrote:

| On Mon, Oct 28, 2002 at 10:44:20AM -0800, chrisl@vmware.com wrote:
| > They are the same as shmfs to linux kernel. Why does vmware not use it
| > in the first place? It is possible due to some the history reason.
| >
| > BTW, I have another question. For the 8G memory machine, do we need
| > to setup 16G swap space? Think about the time it take to write 16G
| > data, does it still make sense that swap space is twice  as big as
| > memory?
|
| swap space doesn't need to be twice as big as ram. That's fixed long
| ago.
|
| swap+ram is the total amount of virtual memory that you can use in
| vmware.
|
| > And the swap partition has limit as 2G. So we need to setup 8 swap
| > partitions if we want 16G swap.
|
| that's a silly restriction of mkswap, the kernel doesn't care, it can
| handle way more than 2G (however there's an high bound at some
| unpractical level, to go safe the math limit should be re-encoded in
| mkswap, of course it changes for every arch because the pte layout is
| different).

Heh, you hit one of my personal todo list items (larger swap spaces :),
so I'll be looking into it, or trying to help anyone else on it
if they want it.

-- 
~Randy

