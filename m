Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261687AbSJGS0K>; Mon, 7 Oct 2002 14:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262517AbSJGS0A>; Mon, 7 Oct 2002 14:26:00 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:51841 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261687AbSJGSZF>;
	Mon, 7 Oct 2002 14:25:05 -0400
Date: Mon, 7 Oct 2002 13:30:27 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: "David S. Miller" <davem@redhat.com>
cc: alan@lxorguk.ukuu.org.uk, <RogerWhile@sim-basis.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Make 2.5.40-ac5 fails
In-Reply-To: <20021007.085211.83878631.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210071326270.3323-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, David S. Miller wrote:

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 07 Oct 2002 16:57:45 +0100
>    
>    A lot of the ISDN layer hasn't yet been updated to the new locking,
>    ditto a few bits of the netfilter code
> 
> The netfilter bits are just missing generic exports of stuff after
> Ingo's threading changes.

The following patch hasn't been merged yet.  I've been carrying it for a 
couple of kernel revisions.

--- linux-2.5-tm/kernel/ksyms.cksyms.c.orig	Sat Oct  5 19:43:21 2002
+++ linux-2.5-tm/kernel/ksyms.cksyms.c	        Sat Oct  5 20:04:00 2002
@@ -600,6 +600,8 @@
 EXPORT_SYMBOL(init_thread_union);
 
 EXPORT_SYMBOL(tasklist_lock);
+EXPORT_SYMBOL(find_task_by_pid);
+EXPORT_SYMBOL(next_thread);
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif

