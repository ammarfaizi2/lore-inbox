Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWBFE5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWBFE5g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWBFE5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:57:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26770 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750978AbWBFE5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:57:35 -0500
Date: Sun, 5 Feb 2006 20:57:09 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop ==== emergency
Message-Id: <20060205205709.0b88171b.zaitcev@redhat.com>
In-Reply-To: <mailman.1139006040.12873.linux-kernel2news@redhat.com>
References: <mailman.1139006040.12873.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006 21:37:09 +0000 (GMT), Hugh Dickins <hugh@veritas.com> wrote:

> +++ linux/arch/i386/kernel/traps.c	2006-02-03 09:59:37.000000000 +0000
> @@ -166,7 +166,8 @@ static void show_trace_log_lvl(struct ta
>  		stack = (unsigned long*)context->previous_esp;
>  		if (!stack)
>  			break;
> -		printk(KERN_EMERG " =======================\n");
> +		printk(log_lvl);
> +		printk(" =======================\n");
>  	}

This is wrong, Hugh. What do you think the priority of the second printk?
It's not log_lvl, that's for sure.

-- Pete
