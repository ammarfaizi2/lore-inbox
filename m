Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTL2EJc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 23:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTL2EJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 23:09:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:24301 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262674AbTL2EJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 23:09:31 -0500
Date: Sun, 28 Dec 2003 20:09:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: mfedyk@matchmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, phillips@arcor.de
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
In-Reply-To: <20031229025507.GT22443@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312282000390.11299@home.osdl.org>
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it>
 <2003Dec27.212103@a0.complang.tuwien.ac.at> <Pine.LNX.4.58.0312271245370.2274@home.osdl.org>
 <m1smj596t1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0312272046400.2274@home.osdl.org>
 <20031228163952.GQ22443@holomorphy.com> <20031229003631.GE1882@matchmail.com>
 <20031229025507.GT22443@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Dec 2003, William Lee Irwin III wrote:
> 
> Doubtful. I suspect he may be referring to pgcl (sometimes called
> "subpages"), though Dan Phillips hasn't been involved in it. I guess
> we'll have to wait for Linus to respond to know for sure.

I didn't see the patch itself, but I spent some time talking to Daniel
after your talk at the kernel summit. At least I _think_ it was him I was 
talking to - my memory for names and faces is basically zero.

Daniel claimed to have it working back then, and that it actually shrank
the kernel source code. The basic approach is to just make PAGE_SIZE
larger, and handle temporary needs for smaller subpages by just
dynamically allocating "struct page" entries for them. The size reduction
came from getting rid of the "struct buffer_head", because it ends up
being just another "small page".

Daniel, details?

		Linus
