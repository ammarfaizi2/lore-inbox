Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbUALWua (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUALWua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:50:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:39624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263522AbUALWu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:50:27 -0500
Date: Mon, 12 Jan 2004 14:51:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
Cc: bart@samwel.tk, kai.a.krueger@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Message-Id: <20040112145124.68ec3068.akpm@osdl.org>
In-Reply-To: <1073940669.30991.7.camel@LNX.iNES.RO>
References: <200401121707.i0CH7iQ11796@mailgate5.cinetic.de>
	<4002F627.8000508@samwel.tk>
	<1073940669.30991.7.camel@LNX.iNES.RO>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO> wrote:
>
> This e-mail is written using "LD_PRELOAD=no-fsync.so evolution", and the
> disc does not spin up every time I switch to another folder or just
> another e-mail.
> 
> ...
> Now I wonder what will happen if I do this system-wide...

I think it's a valid thing to do, personally.  I had a "personal
laptop-mode" patch ages ago which just disabled fsync, fdatasync and O_SYNC
kernel-wide.  Gone.

It's the sort of thing which email purists tend to get emotional about, but
really this is a choice which should be made available to the user if you
want to do this thing properly.


sync() needs to still work.  If you have some app which calls sync() all
the time then you lose.

