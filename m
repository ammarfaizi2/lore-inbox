Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbTD3INs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 04:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTD3INs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 04:13:48 -0400
Received: from [12.47.58.171] ([12.47.58.171]:19967 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261907AbTD3INr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 04:13:47 -0400
Date: Wed, 30 Apr 2003 01:26:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrei Ivanov <andrei.ivanov@ines.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm3
Message-Id: <20030430012642.4463d3f3.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50L0.0304301055510.4051-100000@webdev.ines.ro>
References: <20030429235959.3064d579.akpm@digeo.com>
	<Pine.LNX.4.50L0.0304301055510.4051-100000@webdev.ines.ro>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2003 08:26:00.0815 (UTC) FILETIME=[21C837F0:01C30EF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Ivanov <andrei.ivanov@ines.ro> wrote:
>
> net/core/netfilter.c: In function `nf_reinject':
> net/core/netfilter.c:559: `i' undeclared (first use in this function)


diff -puN net/core/netfilter.c~netfilter-fix net/core/netfilter.c
--- 25/net/core/netfilter.c~netfilter-fix	2003-04-30 01:23:39.000000000 -0700
+++ 25-akpm/net/core/netfilter.c	2003-04-30 01:23:54.000000000 -0700
@@ -550,6 +550,7 @@ void nf_reinject(struct sk_buff *skb, st
 		 unsigned int verdict)
 {
 	struct list_head *elem = &info->elem->list;
+	struct list_head *i;
 
 	rcu_read_lock();
 

_

