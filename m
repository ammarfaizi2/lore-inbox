Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbUC2Sph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUC2Sph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:45:37 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:11397 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263044AbUC2Spf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:45:35 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 29 Mar 2004 10:45:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ivan Godard <igodard@pacbell.net>
cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel support for peer-to-peer protection models...
In-Reply-To: <082a01c41562$cecdf940$fc82c23f@pc21>
Message-ID: <Pine.LNX.4.44.0403291019290.2275-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004, Ivan Godard wrote:

> Ah! you wanted to know about exec, not fork. A true fork() is pretty rare
> these days anyway. Still, the answer is pretty much the same: the fork()
> gets you a new data space, retaining the old code space, and the exec()
> finds (or creates) the code space that cmd's code is in and switches the
> active code space to that space. Heritable data, such as file descriptors,
> won't have been in the old data space anyway, so the child references them
> through syscalls just as in a conventional.
> 
> Perhaps I'm missing your question here, but in general we see no problem
> with fork/exec in our model - it's one of the least changed things. You
> always get a new address space on a conventional, and you also do with a
> Mill; the only difference is that you don't have to shoot down the cache or
> TLB, so a fork/exec should be quite a bit faster.

No, sorry. Lossy email compression (sometimes being concise is a virtue 
but I usually fall way too far). Reading thru previous messages seems 
confusing to me. On one side you say that fork() uses a std COW, on the 
other side you say that the unified virtual address space combined with 
virtually tagged cache let you avoid cache flushes. As soon as you COW, 
you have one virtual address that refer to two different physical addresses.
Does the virtual address have extra tag bits to identify the task?



- Davide





