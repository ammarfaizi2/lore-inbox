Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSKRQjM>; Mon, 18 Nov 2002 11:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSKRQjL>; Mon, 18 Nov 2002 11:39:11 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:13981 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262877AbSKRQjL>; Mon, 18 Nov 2002 11:39:11 -0500
Date: Mon, 18 Nov 2002 10:46:10 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Richard Henderson <rth@twiddle.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: in-kernel linking issues
In-Reply-To: <20021115045146.A23944@twiddle.net>
Message-ID: <Pine.LNX.4.44.0211181040490.24137-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2002, Richard Henderson wrote:

> [...]
> 
> 	ld -T z.ld -shared -o z.so z.o

BTW, this reminds me of something various people and me have been thinking
about for some time, i.e. postprocessing the .o files to generate the 
actual module object.

It seems there are various reasons to do that, possibly the linker issues
which triggered the above, the new - yet to be introduced - module version
mechanism (I think), and it provides additional benefits like e.g. being
able to add the kernel version info in that step, so that a change in
EXTRAVERSION doesn't cause a rebuild of just about everything.

A related question would be a good suffix for kernel modules, e.g
"foo.mo" or "foo.ko" as in module object or kernel object?

--Kai


