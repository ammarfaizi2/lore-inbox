Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbTDWXKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTDWXKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:10:42 -0400
Received: from [12.47.58.232] ([12.47.58.232]:25778 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264299AbTDWXKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:10:42 -0400
Date: Wed, 23 Apr 2003 16:20:41 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, alan@lxorguk.ukuu.org.uk,
       andre@linux-ide.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (0/4)
Message-Id: <20030423162041.1b7ee5b3.akpm@digeo.com>
In-Reply-To: <20030423231353.GA21346@win.tue.nl>
References: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl>
	<20030423153500.0d99b4d3.akpm@digeo.com>
	<20030423231353.GA21346@win.tue.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Apr 2003 23:22:44.0742 (UTC) FILETIME=[3E87B260:01C309EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> On Wed, Apr 23, 2003 at 03:35:00PM -0700, Andrew Morton wrote:
> 
> > What is special about the IDE ioctl approach?
> 
> Usually one wants to use the standard commands for I/O.
> But if the purpose is to talk to the drive (set password,
> set native max, eject, change ZIP drive from big floppy
> mode to removable disk mode, etc. etc.) then one needs
> a means to execute IDE commands "by hand".

Yes, but none of these are performance-critical and they don't involve
large amnounts of data.  A copy is OK.

If all the rework against bio_map_user() and friends is needed for other
reasons then fine.  But it doesn't seem to be needed for the IDE taskfile
ioctl.

