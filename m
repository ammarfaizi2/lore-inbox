Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTJ1BYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTJ1BXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:23:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:63401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263805AbTJ1BXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:23:53 -0500
Date: Mon, 27 Oct 2003 17:23:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Andi Kleen <ak@muc.de>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PS/2 mouse rate setting
In-Reply-To: <20031028005525.GC2886@ucw.cz>
Message-ID: <Pine.LNX.4.44.0310271721070.1600-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Oct 2003, Vojtech Pavlik wrote:
> 
> Thanks, this one is good.

Note that the final one that made it into the kernel was slightly 
different, in that I worry about the fact that "psmouse_command" can 
change the source array, so I didn't do the "static" part (I know, I know, 
I looked up PSMOUSE_CMD_SETRATE and it has zero result bytes, but I 
decided to keep the patch minimal).

I also did the test for not-set in the caller, rather than change the rate 
setting itself. 

		Linus

