Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUDIJJS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 05:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUDIJJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 05:09:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:35463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261159AbUDIJJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 05:09:17 -0400
Date: Fri, 9 Apr 2004 02:09:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org, anton@megashop.ru
Subject: Re: 2.6.X kernel memory leak?
Message-Id: <20040409020903.0897857d.akpm@osdl.org>
In-Reply-To: <200404091117.01011.rathamahata@php4.ru>
References: <200401311940.28078.rathamahata@php4.ru>
	<200402281756.08260.rathamahata@php4.ru>
	<200404081308.43056.rathamahata@php4.ru>
	<200404091117.01011.rathamahata@php4.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
>
> And here is part of sysrq-T for the third machine, which have just locked up,
>  kernel is 2.6.5-rc3-aa2.

It does look like a kernel memory leak, but it's not into slab.

You've disabled iptables.  Possibly there's a leak in a device driver? 
Which drivers are in regular use there?  What are you using for those
hardware RAID controllers?

