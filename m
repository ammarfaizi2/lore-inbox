Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267741AbTAIUM4>; Thu, 9 Jan 2003 15:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267742AbTAIUM4>; Thu, 9 Jan 2003 15:12:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34317 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267741AbTAIUMz>; Thu, 9 Jan 2003 15:12:55 -0500
Date: Thu, 9 Jan 2003 12:20:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Luca Barbieri <ldb@ldb.ods.org>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use %ebp rather than %ebx for thread_info pointer
In-Reply-To: <Pine.LNX.3.95.1030109150728.27501A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0301091219070.1890-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Jan 2003, Richard B. Johnson wrote:
> 
> If you use EBP as an index register, i.e., "movl (%ebp), %eax", it
> will be relative to the SS, not ES or DS. Is this what you want?

That's fine, both SS and DS are 32-bit flat segments everywhere in the
kernel (they have different descriptors - __KERNEL_DS vs __USER_DS, but
they do the same thing)

		Linus

