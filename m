Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTJMKJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTJMKJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:09:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:40840 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261380AbTJMKJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:09:17 -0400
Date: Mon, 13 Oct 2003 03:12:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] SMP races in the timer code, timer-fix-2.6.0-test7-A0
Message-Id: <20031013031225.06ef0d45.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.56.0310111807590.10679@earth>
References: <3F881B46.6070301@colorfullife.com>
	<Pine.LNX.4.56.0310111713440.8641@earth>
	<Pine.LNX.4.56.0310111807590.10679@earth>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> On Sat, 11 Oct 2003, Ingo Molnar wrote:
> 
> > since this would be the 8th word-sized field in struct timer_list,
> > making it a nice round structure size.
> 
> it's the 9th field in fact, due to timer->magic.
> 

We can remove the debug code now.  Or wrap it in a debug config option.

