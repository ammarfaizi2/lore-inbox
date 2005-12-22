Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVLVL4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVLVL4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 06:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVLVL4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 06:56:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39133 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964798AbVLVL4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 06:56:07 -0500
Date: Thu, 22 Dec 2005 03:54:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk,
       bcrl@kvack.org, rostedt@goodmis.org, hch@infradead.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-Id: <20051222035443.19a4b24e.akpm@osdl.org>
In-Reply-To: <20051222114147.GA18878@elte.hu>
References: <20051222114147.GA18878@elte.hu>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> this is the -V4 of the mutex subsystem patch-queue.
>

I've only been following this with half an eye, with the apparently
erroneous expectation that future versions of the patchset would come with
some explanation of why on earth we'd want to merge all this stuff into the
kernel.

We've seen some benchmarks which indicate that there are performance gains
to be had if there's a lot of lock contention, but isn't it the case that
this is because of the semi-extra wake_up() in down()?  Has anyone tried to
redo existing semaphores so they no longer have that disadvantage?
