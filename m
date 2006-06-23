Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWFWSvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWFWSvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWFWSvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:51:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21164 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751530AbWFWSvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:51:08 -0400
Message-ID: <449C3817.2030802@garzik.org>
Date: Fri, 23 Jun 2006 14:51:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
References: <200606231502.k5NF2jfO007109@hera.kernel.org>
In-Reply-To: <200606231502.k5NF2jfO007109@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit e6022603b9aa7d61d20b392e69edcdbbc1789969
> tree f94b059e312ea7b2f3c4d0b01939e868ed525fb0
> parent 304c4c841a31c780a45d65e389b07706babf5d36
> author Andrew Morton <akpm@osdl.org> Fri, 23 Jun 2006 16:05:32 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> Fri, 23 Jun 2006 21:43:05 -0700
> 
> [PATCH] ext3_clear_inode(): avoid kfree(NULL)
> 
> Steven Rostedt <rostedt@goodmis.org> points out that `rsv' here is usually
> NULL, so we should avoid calling kfree().
> 
> Also, fix up some nearby whitespace damage.
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Dumb question...  why?  kfree(NULL) has always been explicitly allowed.

	Jeff


