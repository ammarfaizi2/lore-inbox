Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbTBLQEL>; Wed, 12 Feb 2003 11:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbTBLQEL>; Wed, 12 Feb 2003 11:04:11 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:52239 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267564AbTBLQEJ>; Wed, 12 Feb 2003 11:04:09 -0500
Date: Wed, 12 Feb 2003 16:13:51 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] input: Get rid of kbd_pt_regs [5/14]
In-Reply-To: <20030212120242.D1563@ucw.cz>
Message-ID: <Pine.LNX.4.44.0302121611090.31435-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One idea about kbd_pt_regs. Only one function, fn_show_ptregs, uses 
kbd_pt_regs. Instaed of passing reg data around wouldn't be better to 
just remove fn_show_ptregs from the FN_HANDLERS and call it independently 
inside of kbd_keycode instead.

