Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWISWBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWISWBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWISWBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:01:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751140AbWISWBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:01:15 -0400
Date: Tue, 19 Sep 2006 15:01:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Math-emu kills the kernel on Athlon64 X2
In-Reply-To: <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com> 
 <p73venk2sjw.fsf@verdi.suse.de> <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Sep 2006, Jesper Juhl wrote:
> 
> The config is attached.

Can you try without SMP, and with CONFIG_X86_GENERIC (the latter to make 
sure that we don't do any static optimizations: right now you've told the 
compile system that you're compiling for an Opteron, and while I _think_ 
all the SSE optimizations are dynamic at run-time, I haven't checked 
extensively.
