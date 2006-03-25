Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWCYBwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWCYBwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 20:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWCYBwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 20:52:25 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:10949
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751612AbWCYBwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 20:52:24 -0500
Subject: Re: [PATCH] synclink_gt add gpio feature
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060324161350.0a18c29b.akpm@osdl.org>
References: <1143216251.8513.3.camel@amdx2.microgate.com>
	 <20060324141929.1fff0c15.akpm@osdl.org> <44247812.1040301@microgate.com>
	 <20060324151245.299ff2c1.akpm@osdl.org>
	 <1143244969.2594.24.camel@localhost.localdomain>
	 <20060324161350.0a18c29b.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 19:52:18 -0600
Message-Id: <1143251538.2594.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 16:13 -0800, Andrew Morton wrote:
> It should be possible to communicate between waker and waiter via
> __wait_queue.private and __wait_queue.func.  Make ->private point at some
> on-stack thing, let the waker read and write that.
> 
> That'd involve some rather low-level poking at waitqueues, but I don't
> expect those facilities are going away.

__wait_queue.private already holds a
pointer to the task structure of the waiting process

I might be able to implement what I need in a way
that more closely resembles how wait_on_bit extends
the standard wait queue. But the result is the same:
a new wrapper (new structure containing wait_queue_t
and access/init functions) built on top of the
existing wait queue.

I'll revisit this tomorrow to make sure I'm
thinking about this correctly.

--
Paul



