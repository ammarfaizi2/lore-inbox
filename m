Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVFUH6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVFUH6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVFUH5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:57:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261969AbVFUG3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:29:49 -0400
Date: Mon, 20 Jun 2005 23:29:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-Id: <20050620232925.41bded87.akpm@osdl.org>
In-Reply-To: <208690000.1119330454@[10.10.2.4]>
References: <208690000.1119330454@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> OK, after fixing the build failure with Andy's patch here:
> 
> http://mbligh.org/abat/apw_pci_assign_unassigned_resources

yup, I have that now.

> I get a boot failure on the NUMA-Q box. Full log is here:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/6184/debug/console.log
> 
> But at the end it prints out lots of wierd scheduler stuff, then one more
> message, then dies:
> 
> | migration cost matrix (max_cache_size: 2097152, cpu: 700 MHz):
> ---------------------

That's Ingo debug stuff.

> --------------------------------
> NET: Registered protocol family 16
> 

Well it got up to core_initcall(netlink_proto_init);

> 
> I guess I'll try backing out the scheduler patches unless someone else 
> has a brighter idea?

It doesn't look like a scheduler thing.  Tried enabling initcall_debug?
