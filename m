Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUAJCYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 21:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUAJCYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 21:24:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:13230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264450AbUAJCYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 21:24:13 -0500
Date: Fri, 9 Jan 2004 18:24:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peng Yong <ppyy@bentium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system resource limit in kernel 2.6
Message-Id: <20040109182450.462bc537.akpm@osdl.org>
In-Reply-To: <20040110095333.0765.PPYY@bentium.com>
References: <20040110095333.0765.PPYY@bentium.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peng Yong <ppyy@bentium.com> wrote:
>
> 
> We upgrade one of our production http server, runing apache 1.3.29, to
> kernel 2.6. some time the main process of apache exit and here is the
> error log:
> 
> [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> [Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
> 
> 
> how can i tuning the kernel and remove the system resource limit?
> 

Well the question is: why did behaviour change relative to 2.4?  The kernel
is saying that uid 65534 has exceeded its RLIMIT_NPROC threshold.

How may processes is user 65534 actually running, and how much memory does
the machine have?
