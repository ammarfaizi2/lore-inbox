Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbUKHJec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbUKHJec (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbUKHJdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:33:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:28609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261812AbUKHJ1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:27:15 -0500
Date: Mon, 8 Nov 2004 01:27:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick Mau <mau@oscar.ping.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Workaround for wrapping loadaverage
Message-Id: <20041108012707.1e141772.akpm@osdl.org>
In-Reply-To: <20041108001932.GA16641@oscar.prima.de>
References: <20041108001932.GA16641@oscar.prima.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mau <mau@oscar.ping.de> wrote:
>
> n a previous message archived at
> 
>  http://www.ussg.iu.edu/hypermail/linux/kernel/0410.2/2950.html
> 
>  I described a problem with a wrapping load average on my SMP system.
>  The following small userspace load simulation exactly matches the
>  numbers I am seeing.
> 
>  We can only account for 1024 runnable processes, since we have 22 bits
>  precision, I would like to suggest a patch to calc_load in kernel/timer.c
>  that would limit the number of active tasks:
> 
> 
>  if (active_tasks > 1024 * FIXED_1)
>  	active_tasks = 1024 * FIXED_1;
> 

It's better than wrapping to zero...

Why do we need 11 bits after the binary point?
