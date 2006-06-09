Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWFISjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWFISjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWFISjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:39:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52624 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030363AbWFISjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:39:15 -0400
Date: Fri, 9 Jun 2006 11:38:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@openvz.org>
Cc: devel@openvz.org, xemul@openvz.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com, herbert@13thfloor.at, saw@sw.ru,
       serue@us.ibm.com, sfrench@us.ibm.com, sam@vilain.net,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH 1/6] IPC namespace core
Message-Id: <20060609113802.9815aab5.akpm@osdl.org>
In-Reply-To: <44898D52.4080506@openvz.org>
References: <44898BF4.4060509@openvz.org>
	<44898D52.4080506@openvz.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2006 19:01:38 +0400
Kirill Korotaev <dev@openvz.org> wrote:

> --- ./include/linux/init_task.h.ipcns	2006-06-06 14:47:58.000000000 +0400
> +++ ./include/linux/init_task.h	2006-06-08 14:28:23.000000000 +0400
> @@ -73,6 +73,7 @@ extern struct nsproxy init_nsproxy;
>  	.count		= ATOMIC_INIT(1),				\
>  	.nslock		= SPIN_LOCK_UNLOCKED,				\
>  	.uts_ns		= &init_uts_ns,					\
> +	.ipc_ns		= &init_ipc_ns,					\
>  	.namespace	= NULL,						\
>  }

Not all the new additions here are inside CONFIG_IPC_NS.  It'd be nice to
make it so.

