Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTJEFhL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 01:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbTJEFhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 01:37:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:34774 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262971AbTJEFhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 01:37:09 -0400
Date: Sat, 4 Oct 2003 22:38:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: insecure@mail.od.ua
Cc: jgarzik@pobox.com, lm@bitmover.com, hannal@us.ibm.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Minutes from 10/1 LSE Call
Message-Id: <20031004223838.338bf4f4.akpm@osdl.org>
In-Reply-To: <200310030138.34430.insecure@mail.od.ua>
References: <37940000.1065035945@w-hlinder>
	<200310022156.49678.insecure@mail.od.ua>
	<3F7C780C.9040001@pobox.com>
	<200310030138.34430.insecure@mail.od.ua>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

insecure <insecure@mail.od.ua> wrote:
>
> So:
>  * we hit a ceiling of ~133 Mb/s, no matter how many disks
>  * CPU utilization is 100%, spent mostly in copy_to_user
>  * RAM bandwidth is >1Gb/s
> 
>  These can't be true at once.

True.  But bear in mind that the data crosses the memory busses up to three
times: disk to pagecache, pagecache to CPU, CPU to user memory.

So top speed may be as little as 300 MB/sec.


