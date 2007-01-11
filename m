Return-Path: <linux-kernel-owner+w=401wt.eu-S965176AbXAKEyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbXAKEyA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 23:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbXAKEyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 23:54:00 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55729 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965107AbXAKEx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 23:53:59 -0500
Date: Wed, 10 Jan 2007 20:52:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu,
       Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-Id: <20070110205248.75d51b99.akpm@osdl.org>
In-Reply-To: <20070111031335.GA8392@in.ibm.com>
References: <20061227153855.GA25898@in.ibm.com>
	<20061228082308.GA4476@in.ibm.com>
	<20070103141556.82db0e81.akpm@osdl.org>
	<20070104045621.GA8353@in.ibm.com>
	<20070104090242.44dd8165.akpm@osdl.org>
	<20070110054419.GA3542@in.ibm.com>
	<20070110170829.31997fee.akpm@osdl.org>
	<20070111031335.GA8392@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 08:43:36 +0530
Suparna Bhattacharya <suparna@in.ibm.com> wrote:

> > The s/lock_page_slow/lock_page_blocking/ got lost.  I redid it.
> 
> I thought the lock_page_blocking was an alternative you had suggested
> to the __lock_page vs lock_page_async discussion which got resolved later.
> That is why I didn't make the change in this patchset.
> The call does not block in the async case, hence the choice of
> the _slow suffix (like in fs/buffer.c). But if lock_page_blocking()
> sounds more intuitive to you, that's OK. 

I thought people didn't like the "lock_page_slow" name.
