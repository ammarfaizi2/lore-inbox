Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbTBACVc>; Fri, 31 Jan 2003 21:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTBACVc>; Fri, 31 Jan 2003 21:21:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:41715 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264686AbTBACVc>;
	Fri, 31 Jan 2003 21:21:32 -0500
Date: Fri, 31 Jan 2003 18:30:59 -0800
From: Andrew Morton <akpm@digeo.com>
To: David Ford <david+powerix@blue-labs.org>
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: NFS problems, 2.5.5x
Message-Id: <20030131183059.1d37d01f.akpm@digeo.com>
In-Reply-To: <3E3B2D2E.8000604@blue-labs.org>
References: <3E3B2D2E.8000604@blue-labs.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2003 02:30:51.0924 (UTC) FILETIME=[F0577D40:01C2C999]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david+powerix@blue-labs.org> wrote:
>
> Synopsis:  nfsserver:/home/david mount, get dir. entries loops forever, 
> 2.5.59 for client and server.

If the server is ext3+htree then you've hit the htree dir cookie bug.

Use `dumpe2fs -h /dev/hda1 | grep index' to se if you're using htree.

Use `tune2fs -O ^dir_index /dev/hda1' to disable it.


