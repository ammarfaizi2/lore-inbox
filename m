Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTFWGtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 02:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTFWGtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 02:49:23 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:38717 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263737AbTFWGtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 02:49:22 -0400
Date: Mon, 23 Jun 2003 00:04:00 -0700
From: Andrew Morton <akpm@digeo.com>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72: system unusable during upload to slow nfs-server
Message-Id: <20030623000400.4072f94b.akpm@digeo.com>
In-Reply-To: <20030623052004.GA7270@middle.of.nowhere>
References: <20030623052004.GA7270@middle.of.nowhere>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2003 07:03:28.0568 (UTC) FILETIME=[8C51CB80:01C33955]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan <thunder7@xs4all.nl> wrote:
>
> I rsync some directories to a nfs-mount on a very large harddisk on a
>  non-udma system. This system can read/write data at about 3-4 megabyte
>  per second.
> 
>  If I rsync in 2.4, all happens as you'd expect: the update doesn't go
>  fast, but the interactivity of the kernel is good while it's running.
> 
> 
>  In 2.5.7x, it runs really fast for a while (rsync mentions 30 mb/s), and
>  after a while slows down. Then, a mutt-session on another console lags
>  about 10-30 seconds when you press a key. top gives 98% IO-wait.

Please send a `vmstat 1' trace, and the contents of /proc/vmstat
taken when the thing is being sluggish.
