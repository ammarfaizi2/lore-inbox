Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267857AbTAMF0f>; Mon, 13 Jan 2003 00:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267961AbTAMFZt>; Mon, 13 Jan 2003 00:25:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42758 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267965AbTAMFZT>; Mon, 13 Jan 2003 00:25:19 -0500
Date: Sun, 12 Jan 2003 21:29:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <tridge@samba.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] Check compiler version, SMP and PREEMPT.
In-Reply-To: <20030113051434.DC2092C09F@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0301122127130.1310-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Jan 2003, Rusty Russell wrote:
>
> Linus, please apply if you agree.

I don't like this, it doesn't make much sense to me to special-case this 
with some "module .sanity thing".

Instead, why don't you make _every_ object file just contain some magic
section (link-once), and then at module load time you compare the contents
of the section with the kernel magic section.

That magic section can then be arbitrary, with no strange bitmap 
limitations etc. 

		Linus

