Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136768AbREAX1e>; Tue, 1 May 2001 19:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136769AbREAX1Z>; Tue, 1 May 2001 19:27:25 -0400
Received: from www.teaparty.net ([216.235.253.180]:7954 "EHLO www.teaparty.net")
	by vger.kernel.org with ESMTP id <S136768AbREAX1N>;
	Tue, 1 May 2001 19:27:13 -0400
Date: Wed, 2 May 2001 00:26:41 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: David Bronaugh <dbronaugh@opensourcedot.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Breakage of opl3sax cards since 2.4.3 (at least)
In-Reply-To: <20010501153941.E498@Woodbox.gv.shawcable.net>
Message-ID: <Pine.LNX.4.10.10105020022210.17794-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, David Bronaugh wrote:

> opl3sax cards have refused to init in Linux with the in-kernel OSS driver
> since 2.4.3 at least (last I tested and worked was 2.4.1). I'm pretty sure
> this is a kernel issue as it's happened on 2 different machines, one of
> which I never goofed around with.

My card [I should say chipset - built in to mobo] initialised partially.
[Running 2.4.3-ac5]
 
> Usually message is something like:
> 
> opl3sa2: Control I/O port 0x220 (or whatever is tried) is not a YMF7xx
> chipset!

I believe I saw something like this, but the sound subsystem
initialised, it was just the gameport that was dead.

I resurrected it by cat'ing the following into /proc/isapnp

card 0 YMH0802
dev 0 YMH0022
port 0 0x201
activate

What does your /proc/isapnp say?



-- 
Nobody wants constructive criticism.  It's all we can do to put up with
constructive praise.

