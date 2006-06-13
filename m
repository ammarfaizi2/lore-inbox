Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWFMU3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWFMU3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWFMU3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:29:41 -0400
Received: from xenotime.net ([66.160.160.81]:19945 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932137AbWFMU3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:29:41 -0400
Date: Tue, 13 Jun 2006 13:32:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Packing data in kernel memory
Message-Id: <20060613133227.1eee4578.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0606132217110.11918@yvahk01.tjqt.qr>
References: <448F0893.1080706@comcast.net>
	<Pine.LNX.4.61.0606132217110.11918@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006 22:18:55 +0200 (MEST) Jan Engelhardt wrote:

> 
> >Subject: Packing data in kernel memory
> >
> 
> Can't you just use mlock(), if you want to keep it in RAM?
> 
> Or do you need it in kernel memory, because you need it in the lowmem area? 
> Or for interaction with other kernel code?
> 
> >Is there a way to pack and store arbitrary data in the kernel, or do I
> >need to roll my own?

Sounds a bit like a slab cache to me.

> Write a device driver, kmalloc some buffer, and copy data via a write 
> function from userspace to that buffer. Should be trivial.
> 
> >1 excess pages, 4 units wasted memory.
> 
> Of course, kmalloc only works up to some boundary AFIACS.

128 KB on some arches.  More on a few IIRC.

---
~Randy
