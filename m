Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSKFBEb>; Tue, 5 Nov 2002 20:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbSKFBEb>; Tue, 5 Nov 2002 20:04:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:38311 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265247AbSKFBEa>;
	Tue, 5 Nov 2002 20:04:30 -0500
Message-ID: <3DC86C20.7BA743F1@digeo.com>
Date: Tue, 05 Nov 2002 17:10:56 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: linux-aio@kvack.org, lkml <linux-kernel@vger.kernel.org>, bcrl@redhat.com
Subject: Re: [PATCH 1/2] 2.5.46 AIO support for raw/O_DIRECT
References: <200211060101.gA611gE21063@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 01:11:00.0681 (UTC) FILETIME=[5E999390:01C28531]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> 
> Hi,
> 
> Here is (part 1/2) 2.5.46 patch to support AIO for raw/O_DIRECT.
> 
> This patch adds the infrastructure only. It does not make
> DIO code Async. (part 2/2 does). Here is summary of what this
> patch does:
> 
> 1) Adds generic_file_aio_write_nolock() and makes all other
>    generic_file_*_write() to use it.
> 
> 2) Modifies generic_file_direct_IO() and ->direct_IO() functions
>    to take "kiocb *" instead of "file *".
> 
> 3) Renames generic_direct_IO() to blockdev_direct_IO().
>         (Andrew's suggestion)
> 
> 4) Moves generic_file_direct_IO() to mm/filemap.c
>         (Andrew's suggestion)
> 
> 5) Adds AIO read/write support for raw driver.
> 

Looks sane.  Did nfs_direct_IO() not need updating?
