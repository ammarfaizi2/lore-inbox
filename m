Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVA0Irp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVA0Irp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 03:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVA0Irp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 03:47:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:40172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262310AbVA0Iro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 03:47:44 -0500
Date: Thu, 27 Jan 2005 00:47:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-Id: <20050127004732.5d8e3f62.akpm@osdl.org>
In-Reply-To: <20050127082809.A20510@flint.arm.linux.org.uk>
References: <20050121161959.GO3922@fi.muni.cz>
	<1106360639.15804.1.camel@boxen>
	<20050123091154.GC16648@suse.de>
	<20050123011918.295db8e8.akpm@osdl.org>
	<20050123095608.GD16648@suse.de>
	<20050123023248.263daca9.akpm@osdl.org>
	<20050123200315.A25351@flint.arm.linux.org.uk>
	<20050124114853.A16971@flint.arm.linux.org.uk>
	<20050125193207.B30094@flint.arm.linux.org.uk>
	<20050127082809.A20510@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> This mornings magic numbers are:
> 
>  3
>  ip_dst_cache        1292   1485    256   15    1

I just did a q-n-d test here: send one UDP frame to 1.1.1.1 up to
1.1.255.255.  The ip_dst_cache grew to ~15k entries and grew no further. 
It's now gradually shrinking.  So there doesn't appear to be a trivial
bug..

>  Is no one interested in the fact that the DST cache is leaking and
>  eventually takes out machines?  I've had virtually zero interest in
>  this problem so far.

I guess we should find a way to make it happen faster.
