Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbUCOXWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbUCOXWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:22:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:23757 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262846AbUCOXV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:21:56 -0500
Date: Mon, 15 Mar 2004 15:23:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 ext3fs half order of magnitude slower than xfs - bulk
 write
Message-Id: <20040315152355.32a1b054.akpm@osdl.org>
In-Reply-To: <20040315214741.GA5042@merlin.emma.line.org>
References: <20040315214741.GA5042@merlin.emma.line.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:
>
> ext3fs runs in the default data=ordered mode for one test and
> data=writeback for another. xfs runs in default mode without special
> realtime tricks or such. XFS is at least by a factor three faster than
> even ext3 -o data=writeback.

It should be possible to generate a simple testcase which demonstrates this
problem on that machine.  Is that something you can do?

>From your description, write-and-fsync.c from

	http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz

would be a good starting point.
