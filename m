Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTL2JgY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTL2JeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:34:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:51417 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263185AbTL2JeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:34:05 -0500
Date: Mon, 29 Dec 2003 01:33:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: mfedyk@matchmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, phillips@arcor.de
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
In-Reply-To: <20031229092203.GL27687@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312290129510.11299@home.osdl.org>
References: <2003Dec27.212103@a0.complang.tuwien.ac.at>
 <Pine.LNX.4.58.0312271245370.2274@home.osdl.org> <m1smj596t1.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.58.0312272046400.2274@home.osdl.org> <20031228163952.GQ22443@holomorphy.com>
 <20031229003631.GE1882@matchmail.com> <20031229025507.GT22443@holomorphy.com>
 <Pine.LNX.4.58.0312282000390.11299@home.osdl.org> <20031229065240.GU22443@holomorphy.com>
 <Pine.LNX.4.58.0312290112450.11299@home.osdl.org> <20031229092203.GL27687@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, William Lee Irwin III wrote:
> 
> I can't say I'm particularly encouraged by what I've heard thus far,

Well, I don't even know what your approach is - mind giving an overview? 

My original plan (and you can see some of it in the fact that 
PAGE_CACHE_SIZE is separate from PAGE_SIZE), was to just have the page 
cache be able to use bigger pages than the "normal" pages, and the 
normal pages would continue to be the hardware page size.

However, especially with mem_map[] becoming something of a problem, and 
all the problems we'd have if PAGE_SIZE and PAGE_CACHE_SIZE were 
different, I suspect I'd just be happier with increasing PAGE_SIZE 
altogether (and PAGE_CACHE_SIZE with it), and then just teaching the VM 
mapping about "fractional pages".

What's your approach?

		Linus
