Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbSJ2Sv4>; Tue, 29 Oct 2002 13:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSJ2Sv4>; Tue, 29 Oct 2002 13:51:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:60321 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262020AbSJ2Svw>;
	Tue, 29 Oct 2002 13:51:52 -0500
Message-ID: <3DBEDA40.449C8FFC@digeo.com>
Date: Tue, 29 Oct 2002 10:58:08 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <badari@us.ibm.com>
CC: linux-aio@kvack.org, lkml <linux-kernel@vger.kernel.org>,
       cel@citi.umich.edu
Subject: Re: [RFC] generic_file_direct_IO() argument changes for AIO
References: <200210291819.g9TIJvO16528@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2002 18:58:08.0770 (UTC) FILETIME=[1F029E20:01C27F7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> 
> Hi,
> 
> Inorder to support AIO for raw/O_DIRECT, I need to add "struct kiocb *"
> to generic_file_direct_IO() and all direct_IO() ops.
> 
> generic_file_direct_IO(int rw, struct file *file, const struct iovec *iov,
>         loff_t offset, unsigned long nr_segs)
> 
> Instead of adding a new argument, I propose replace
> 
>         "struct file *file" argument with "struct kiocb *iocb"
> 
> One can get "filp" from iocb->ki_filp.
> 
> Any objections ?
> 

OK by me.

BTW, while you're poking around in there could you please rename
generic_direct_IO() to blockdev_direct_IO() and move
generic_file_direct_IO() back into filemap.c?
