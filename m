Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTFCS5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTFCS5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:57:10 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:37262 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262424AbTFCS5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:57:09 -0400
Date: Tue, 3 Jun 2003 12:07:17 -0700
From: Andrew Morton <akpm@digeo.com>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 add_disk(disk) re-registering disk->queue->elevator.kobj
 (bug?!)
Message-Id: <20030603120717.66012855.akpm@digeo.com>
In-Reply-To: <3EDCEA14.2000407@aros.net>
References: <3EDCEA14.2000407@aros.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2003 19:10:37.0213 (UTC) FILETIME=[D0C1B4D0:01C32A03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz <ldl@aros.net> wrote:
>
> Or perhaps the block 
> handling logic was changed such that disks don't share the same 
> request_queue anymore. If so, then a few drivers (like nbd) need to be 
> updated to use a seperate request_queue per disk.

The ramdisk driver was recently changed to do exactly this.  From what
you say it appears that nbd needs the same treatment.
