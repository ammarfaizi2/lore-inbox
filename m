Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269226AbTGaVBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269232AbTGaVBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:01:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:31368 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269226AbTGaVBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:01:49 -0400
Date: Thu, 31 Jul 2003 13:49:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: rusty@rustcorp.com.au, andrea@suse.de, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2
Message-Id: <20030731134954.54108d95.akpm@osdl.org>
In-Reply-To: <20030731185806.GC1990@in.ibm.com>
References: <20030731185806.GC1990@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> I have merged Rusty's original patch for reducing the size of
> rcu_heads by splitting the two main changes into two patches.

There are probably a lot of data structures in which we could save 4 (or 8)
bytes by converting things from doubly linked to singly linked.

And that's good, but given that at this time we are concentrating 100% on
stabilising 2.6 (aren't we?) I'll be letting these patches slide, thanks.
