Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbULHCOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbULHCOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbULHCOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:14:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:60647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262002AbULHCL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:11:57 -0500
Date: Tue, 7 Dec 2004 18:11:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: nickpiggin@yahoo.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-Id: <20041207181137.2998369c.akpm@osdl.org>
In-Reply-To: <20041208020923.GG16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de>
	<20041202134801.GE10458@suse.de>
	<20041202114836.6b2e8d3f.akpm@osdl.org>
	<20041202195232.GA26695@suse.de>
	<20041208003736.GD16322@dualathlon.random>
	<1102467253.8095.10.camel@npiggin-nld.site>
	<20041208013732.GF16322@dualathlon.random>
	<1102470428.8095.29.camel@npiggin-nld.site>
	<20041208020923.GG16322@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
>  One hidden side effect of "as" is that by writing so slowly (and
>  64KiB/sec really is slow), it increases the time it will take for a
>  dirty page to be flushed to disk

The 64k/sec only happens for direct-io, and those pages aren't dirty.
