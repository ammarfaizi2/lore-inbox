Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTJIO5W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTJIO5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:57:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:4541 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262268AbTJIO5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:57:15 -0400
Date: Thu, 9 Oct 2003 07:56:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@colin2.muc.de>
cc: Andi Kleen <ak@muc.de>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <bos@serpentine.com>
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
In-Reply-To: <20031009145235.GA47202@colin2.muc.de>
Message-ID: <Pine.LNX.4.44.0310090754280.1694-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Oct 2003, Andi Kleen wrote:
> 
> That is exactly what the patch is doing.

No it's not.

What I'm asking for is a simple

	if (vma->vm_flags & VM_READ)
		make_pages_readable();

kind of thing. A couple of one-liners in the _callers_, not a horribly 
ugly change way down the stack.

Flags are ugly. Multi-value flags that have magic constants are worse. 
This patch deserves to die.

		Linus

