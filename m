Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbTCaX3L>; Mon, 31 Mar 2003 18:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261916AbTCaX3L>; Mon, 31 Mar 2003 18:29:11 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:28616 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261911AbTCaX3K>; Mon, 31 Mar 2003 18:29:10 -0500
Date: Mon, 31 Mar 2003 17:40:27 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put all functions in kallsyms
In-Reply-To: <20030331224033.489DD2C04B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0303311736440.10623-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003, Rusty Russell wrote:

> 	Simple, untested patch.  Any objections?

No objection, but you need to adapt the test in
kernel/kallsyms.c:

	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) {

and in kernel/extable.c:

	if (addr >= (unsigned long)_stext &&
	    addr <= (unsigned long)_etext)

Otherwise, you'd just add bloat with no gain at all ;)

--Kai


