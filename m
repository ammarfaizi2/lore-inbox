Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268076AbTBMQ31>; Thu, 13 Feb 2003 11:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268078AbTBMQ31>; Thu, 13 Feb 2003 11:29:27 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:48138 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268076AbTBMQ31>; Thu, 13 Feb 2003 11:29:27 -0500
Date: Thu, 13 Feb 2003 16:39:10 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] input: Get rid of kbd_pt_regs [5/14]
In-Reply-To: <20030213021333.A6256@ucw.cz>
Message-ID: <Pine.LNX.4.44.0302131637340.20201-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > One idea about kbd_pt_regs. Only one function, fn_show_ptregs, uses 
> > kbd_pt_regs. Instaed of passing reg data around wouldn't be better to 
> > just remove fn_show_ptregs from the FN_HANDLERS and call it independently 
> > inside of kbd_keycode instead.
> 
> I'm not sure if that's really a nicer solution.

Actually why do we have this function in keyboard.c when we have 
sysrq_handle_showregs in sysrq.c? Both do the same thing.

