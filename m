Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbTJPEPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 00:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTJPEPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 00:15:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:35544 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262726AbTJPEPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 00:15:33 -0400
Date: Wed, 15 Oct 2003 21:19:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alberto Bertogli <albertogli@telpin.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5/6 (and probably 7 too) size-4096 memory leak
Message-Id: <20031015211918.1a70c4d2.akpm@osdl.org>
In-Reply-To: <20031016025554.GH4292@telpin.com.ar>
References: <20031016025554.GH4292@telpin.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alberto Bertogli <albertogli@telpin.com.ar> wrote:
>
> I want to report a memory leak for 2.6.0-test5 that I've noticed today on
>  a mail server after 32 days of uptime.
> 
>  As I'm upgrading it tomorrow to test7 I wasn't going to report this until
>  verifying if the behaviour continued, but I saw on kernelnewbies that
>  others were having this issue with test7 too, so I decided to post a
>  report with the information before I reboot the server.
> 
>  The attached files are gzipped for space reasons, and were taken at night
>  when the server isn't very loaded.
> 
>  The workload is a simple sendmail with ipop3d and imapd, nothing much, for
>  about 6500 users; the machine is a dual Pentium III with 1gb of RAM and a
>  couple of SCSI disks.
> 
>  Slabinfo reports that size-4096 has 104341 active objects and growing.
> 
>  On another box at home I see the same issue with test6, but "only" with
>  11612 objects; I'm not posting info on this box as I guess the mailserver
>  is much more important because the leak is really noticeable.

At least I'm not the only one; my main desktop machine does the same
thing.  It leaks two megabytes a day into size-4096, like clockwork.  It's
up to 43 megs now.

I was ignoring it and hoping it would go away.  Ho hum.  Tricky.
