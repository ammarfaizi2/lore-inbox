Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274991AbTHRTgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275003AbTHRTgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:36:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:57069 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274991AbTHRTgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:36:36 -0400
Date: Mon, 18 Aug 2003 12:36:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
In-Reply-To: <20030818192529.GC19067@gtf.org>
Message-ID: <Pine.LNX.4.44.0308181234500.5929-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Aug 2003, Jeff Garzik wrote:
> 
> There was talk in another thread about fixing up workqueue to create
> a new kernel thread, if one isn't available within five seconds.

That's probably reasonable. Together with some upper limit to active
threads, along with timeouting old queues when idle it would be fairly
flexible. It's how basically all servers end up working, after all. It 
shouldn't be that hard to do.

		Linus

