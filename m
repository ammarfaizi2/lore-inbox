Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVBFSk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVBFSk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVBFSk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:40:57 -0500
Received: from cantor.suse.de ([195.135.220.2]:26522 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261268AbVBFSik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:38:40 -0500
Date: Sun, 6 Feb 2005 19:38:34 +0100
From: Andi Kleen <ak@suse.de>
To: Pawe?? Sikora <pluto@pld-linux.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206183834.GC18245@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <200502061303.12377.pluto@pld-linux.org> <20050206124701.GD30109@wotan.suse.de> <200502061907.28165.pluto@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502061907.28165.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [1] glibc-2.3.4 kill buggy bins at the load time.
>     (please look into: elf/dl-load.c, elf/dl-support.c, elf/rtld.c)

I don't see how that can work for arbitary code executed in some
arbitary mmap. 

Please explain.

>     This works on i386/PaX systems too (hardware NX isn't required).

But it's for the 99.99999% of other users who don't use such
weird third party patches.

> The execstack req. disappeard (~99% of broken sources).

My problem is basically that the effort of fixing these
sources seems to be shifted to x86-64 now in mainstream
linux. And I don't like that.

-Andi
