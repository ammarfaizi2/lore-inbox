Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTA0QRF>; Mon, 27 Jan 2003 11:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTA0QRF>; Mon, 27 Jan 2003 11:17:05 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:11980 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267219AbTA0QRF>; Mon, 27 Jan 2003 11:17:05 -0500
Date: Mon, 27 Jan 2003 10:25:53 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: David Woodhouse <dwmw2@infradead.org>
cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel. 
In-Reply-To: <31172.1043622971@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0301271019560.18686-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2003, David Woodhouse wrote:

> For older kernels you must set O_TARGET, for 2.5 I think the mere act of
> setting it causes the build to break -- that one is gratuitously making it
> harder to make external modules which compile in both and I've complained
> about it before.

Okay, I might get persuaded to take that check out if it really makes life 
harder. Wouldn't it work to not have O_TARGET in the Makefile at all, I 
think 2.4 shouldn't care as long as you just "make modules"?

> Per-file CFLAGS must have a full path specified now in 2.5, whereas in 2.4 
> and earlier it was just 'CFLAGS_filename.o'.

It shouldn't, I kinda deliberately decided to keep the old syntax for 
this. So it would be a bug.

--Kai

