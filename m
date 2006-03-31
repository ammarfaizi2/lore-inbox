Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWCaCwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWCaCwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 21:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWCaCwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 21:52:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751185AbWCaCwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 21:52:18 -0500
Date: Thu, 30 Mar 2006 18:51:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: nickpiggin@yahoo.com.au, torvalds@osdl.org, jeff@garzik.org, axboe@suse.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org, rpeterso@redhat.com
Subject: Re: [PATCH] splice support #2
Message-Id: <20060330185133.176f8210.akpm@osdl.org>
In-Reply-To: <20060330184325.35e21117.akpm@osdl.org>
References: <20060330100630.GT13476@suse.de>
	<20060330120055.GA10402@elte.hu>
	<20060330120512.GX13476@suse.de>
	<Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
	<442C440B.2090700@garzik.org>
	<Pine.LNX.4.64.0603301259220.27203@g5.osdl.org>
	<442C7EF5.8090703@yahoo.com.au>
	<20060330184325.35e21117.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> splice() may not be suitable for such filesystems.

OK, splice() cuts in at the file_operations level, so sych a clustered
filesystem _could_ implement it, but none of the code we have there will be
usable by it.  If the operations in splice.c were to operate at the
file_operations level (->read, ->write) then probably they could be used
thusly.

