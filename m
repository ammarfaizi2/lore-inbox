Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTLBAgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 19:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTLBAgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 19:36:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:55481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264259AbTLBAgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 19:36:39 -0500
Date: Mon, 1 Dec 2003 16:36:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: pinotj@club-internet.fr
cc: manfred@colorfullife.com, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, nathans@sgi.com
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
In-Reply-To: <mnet1.1070127696.1558.pinotj@club-internet.fr>
Message-ID: <Pine.LNX.4.58.0312011606200.2733@home.osdl.org>
References: <mnet1.1070127696.1558.pinotj@club-internet.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Nov 2003 pinotj@club-internet.fr wrote:
>
> I triggered the slab oops with a very small kernel -test11 (~700KB):

The only thing that looks at _all_ likely to explain the problem is

> CONFIG_XFS_FS=y

since there aren't that many XFS users I know of. It's also now the only
thing that uses buffer heads in your config, so..

I assume it's not an option to try another filesystem on this setup, but
it's entirely possible that the 2.6.x buffer-head removal has impacted XFS
negatively - although I'm a bit surprised at how easily you seem to show
problems, since XFS actually has active maintenance.

Nathan - I don't know if you follow linux-kernel, but Jerome Pinot has
been having bad slab problems for some time now. Do normal XFS users
compile with slab debugging turned on?

		Linus
