Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbTCJWfl>; Mon, 10 Mar 2003 17:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbTCJWfl>; Mon, 10 Mar 2003 17:35:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65298 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261504AbTCJWfk>; Mon, 10 Mar 2003 17:35:40 -0500
Date: Mon, 10 Mar 2003 14:44:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org, <ak@muc.de>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
 due to wrmsr (performance)
In-Reply-To: <Pine.LNX.4.44.0303091858530.1420-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303101442050.8558-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Mar 2003, Linus Torvalds wrote:
> 
> Your SYSENTER_ESP hack would probably get back the rest, but I haven't
> seen any patches for it, hint hint.

Oh, well, I just did it myself. And tested with both NMI's and debug 
traps, just to make sure that we do the right thing there too.

(If we get an NMI on the first three instructions in a debug trap that 
happens on the first instruction of the sysenter path, we're still 
screwed. I'm still trying to figure out a good way to unscrew us).

> In the meantime, we're almost back to where we were _and_ we support 
> sysenter (ie my system calls are down by almost a factor of four). So 
> we're doing pretty well.

We're now pretty much back to 2.4.x performance on the scheduler, as far 
as I can tell. Can people confirm and close the bug?

		Linus

