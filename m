Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTBJRaW>; Mon, 10 Feb 2003 12:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTBJRaW>; Mon, 10 Feb 2003 12:30:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14352 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261857AbTBJRaV>; Mon, 10 Feb 2003 12:30:21 -0500
Date: Mon, 10 Feb 2003 09:36:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Fix random memory corruption during suspend-to-RAM resume
In-Reply-To: <20030209203141.GA2223@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0302100934240.7698-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Feb 2003, Pavel Machek wrote:
> 
> We really want to use wakeup_stack as stack, not as pointer to
> stack... Please apply,

Hmm.. The stack grows downwards, are you sure you don't really mean

	mov $(wakeup_end-wakeup_code),%sp

(because wakeup_end is the end of the wakeup_stack area..)

		Linus

