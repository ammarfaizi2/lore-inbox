Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTDWWZF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTDWWZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:25:04 -0400
Received: from [12.47.58.232] ([12.47.58.232]:10922 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264275AbTDWWZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:25:03 -0400
Date: Wed, 23 Apr 2003 15:35:00 -0700
From: Andrew Morton <akpm@digeo.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (0/4)
Message-Id: <20030423153500.0d99b4d3.akpm@digeo.com>
In-Reply-To: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Apr 2003 22:37:03.0949 (UTC) FILETIME=[DCE3DFD0:01C309E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
> 
> Hey,
> 
> Another bunch of patches:
> 
> (1) Enhance bio_(un)map_user() and add blk_rq_bio_prep().
> (2) Pass bdev to IDE ioctl handlers.
> (3) Add support for rq->bio based taskfile.
> (4) Use direct-IO in ide_taskfile_ioctl() and in ide_cmd_ioctl().

Dumb question: what does all this code actually do?

It appears to be implementing an IDE-specific ioctl() which performs bulk
IO direct to/from userspace.  But that seems to be equivalent to O_DIRECT
access to /dev/hda.

What is special about the IDE ioctl approach?

Thanks.
