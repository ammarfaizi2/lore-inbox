Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269250AbUHaXUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269250AbUHaXUz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUHaXUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:20:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:11754 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269250AbUHaXUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:20:40 -0400
Date: Tue, 31 Aug 2004 16:24:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [RFC] buddy allocator without bitmap(2) [0/3]
Message-Id: <20040831162408.3718c83e.akpm@osdl.org>
In-Reply-To: <4134FF50.8000300@jp.fujitsu.com>
References: <41345491.1020209@jp.fujitsu.com>
	<1093969590.26660.4806.camel@nighthawk>
	<4134FF50.8000300@jp.fujitsu.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> Because I had to record some information about shape of mem_map, I used PG_xxx bit.
> 1 bit is maybe minimum consumption.

The point is that we're running out of bits in page.flags.

You should be able to reuse an existing bit for this application.  PG_lock would suit.
