Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTEXRmo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTEXRmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 13:42:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46352 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262490AbTEXRmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 13:42:43 -0400
Date: Sat, 24 May 2003 10:55:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make vt_ioctl ix86isms explicit
In-Reply-To: <20030524173713.GA4939@lst.de>
Message-ID: <Pine.LNX.4.44.0305241046590.10806-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 May 2003, Christoph Hellwig wrote:
>
> sys_ioperm is only implemented on x86 (i386/x86_64).  Make the
> ifdefs in vt_ioctl.c more explicit so the other architectures can
> get rid of their stubs in favour of just using sys_ni_syscall in
> the syscall table.  (Personally I still wonder why they added it
> at all but that's another question..)

They were added because this was how the X server got IO permissions a 
million years ago.  It comes from some random old UNIX/386 thing, it 
predates Linux itself as far as I know.

I'm fairly certain that X itself no longer uses it at all, but there may
be other programs that still do (unlikely). Your patch looks sane,
although it might be equally sane to just remove the code altogether.

			Linus

