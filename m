Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbUBJVH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 16:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUBJVH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 16:07:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:3304 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266109AbUBJVEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 16:04:33 -0500
Date: Tue, 10 Feb 2004 13:05:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brian Jackson <iggy@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc1-mm1
Message-Id: <20040210130559.22b24092.akpm@osdl.org>
In-Reply-To: <200402101345.19015.iggy@gentoo.org>
References: <20040209014035.251b26d1.akpm@osdl.org>
	<200402101345.19015.iggy@gentoo.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Jackson <iggy@gentoo.org> wrote:
>
> kernel bug at mm/slab.c:1107!
> invalid operand:0000 [#1]
> SMP
> 
> (this happened just after the Console: and Memory: lines)
> This didn't happen with 2.6.1-mm4 (that's the last -mm I tried). I can try to 
> track down where it started later, but this is my firewall, so I have to wait 
> till everyone goes to sleep first.

Yes, I know.  Seems that with some configs, each interrupt (only timer
interrupts at this point) is decrementing the preempt count by one.  It's
rather mysterious.

