Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUAEGwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 01:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbUAEGwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 01:52:31 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:45212 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265802AbUAEGwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 01:52:30 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 4 Jan 2004 22:52:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040105064117.0C20C2C065@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0401042243510.16042-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Rusty Russell wrote:

> > But I think it can be avoided, and actually I 
> > don't know why I did not think about this before. We don't need to return 
> > a struct task_struct* for kthread_create(). We can have:
> > 
> > struct kthread_struct {
> 
> Nope.  That's EXACTLY the kind of burden on the caller I wanted to
> avoid if at all possible.

Which burden? The kthread is a resource and a "struct kthread" is an 
handle to the resource. You create the resource (kthread_create()), you 
control the resource (kthread_start()) and you free the resource 
(kthread_stop()). To me it's simple and clean and does not require hacks 
like taking owerships of tasks and using SIGCLD/waitpid to communicate. 
Anyway, that's your baby and you'll take your choice.



- Davide


