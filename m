Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTFJUwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFJUua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:50:30 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:34649 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263973AbTFJUtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:49:47 -0400
Date: Tue, 10 Jun 2003 13:59:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Nathan Conrad <conrad@bungled.net>
Cc: green@namesys.com, davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: ext3 / reiserfs data corruption, 2.5-bk
Message-Id: <20030610135935.5db1abb7.akpm@digeo.com>
In-Reply-To: <20030610214436.GA6719@bungled.net>
References: <20030609193541.GA21106@suse.de>
	<20030610084323.GA16435@namesys.com>
	<20030610214436.GA6719@bungled.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 21:03:28.0247 (UTC) FILETIME=[BD7FC070:01C32F93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Conrad <conrad@bungled.net> wrote:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c016781a
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[find_inode_fast+26/96]    Not tainted

Something scribbled on your inode hash chains.  Please make sure that
you're building the kernel with all the memory debug options enabled, and
run memtest86 on that machine for 12 hourws or so.

