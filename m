Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbTDOOUU (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTDOOUU 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:20:20 -0400
Received: from mx01.cyberus.ca ([216.191.240.22]:12563 "EHLO mx01.cyberus.ca")
	by vger.kernel.org with ESMTP id S261530AbTDOOUN 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 10:20:13 -0400
Date: Tue, 15 Apr 2003 10:31:04 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Tomas Szepe <szepe@pinerecords.com>
cc: linux-kernel@vger.kernel.org, "" <netdev@oss.sgi.com>
Subject: Re: [PATCH] qdisc oops fix
In-Reply-To: <20030415134305.GF15944@louise.pinerecords.com>
Message-ID: <20030415102918.U2397@shell.cyberus.ca>
References: <20030415084706.O1131@shell.cyberus.ca>
 <20030415134305.GF15944@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Can you try a different qdisc - not htb to reproduce the problem?

cheers,
jamal

On Tue, 15 Apr 2003, Tomas Szepe wrote:

> Trace; c01376fd <__kmem_cache_alloc+6d/140>
> Trace; c021b809 <qdisc_create_dflt+29/c0>
> Trace; e0a4b71d <[sch_htb]htb_change_class+40d/600>
> Trace; e0a48108 <[sch_htb]htb_find+58/70>
> Trace; c021d5aa <tc_ctl_tclass+14a/2b0>
> Trace; e0a4d1e0 <[sch_htb]htb_class_ops+0/0>
> Trace; c0219b18 <rtnetlink_rcv_msg+1a8/26d>
> Trace; c0219740 <rtnetlink_rcv+c0/1e0>
> Trace; c0219450 <rtnetlink_dump_ifinfo+0/90>
> Trace; c022121a <netlink_data_ready+7a/80>
> Trace; c02209f1 <netlink_unicast+281/330>
> Trace; c0220f71 <netlink_sendmsg+1f1/290>
> Trace; c020a5c5 <sock_sendmsg+75/c0>
> Trace; c020bce7 <sys_sendmsg+1b7/210>
> Trace; c0130010 <do_buffer_fdatasync+30/b0>
> Trace; c012d5b5 <do_anonymous_page+115/130>
> Trace; c012d821 <handle_mm_fault+81/120>
> Trace; c0117f48 <do_page_fault+188/523>
> Trace; c020b11d <sys_socket+3d/60>
> Trace; c020c1d6 <sys_socketcall+246/270>
> Trace; c0117dc0 <do_page_fault+0/523>
> Trace; c0107800 <error_code+34/3c>
> Trace; c010770f <system_call+33/38>
>
