Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265265AbSKFBNZ>; Tue, 5 Nov 2002 20:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265267AbSKFBNZ>; Tue, 5 Nov 2002 20:13:25 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:31903 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265265AbSKFBNX>;
	Tue, 5 Nov 2002 20:13:23 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200211060117.gA61HQU21775@eng2.beaverton.ibm.com>
Subject: Re: [PATCH 1/2] 2.5.46 AIO support for raw/O_DIRECT
To: akpm@digeo.com (Andrew Morton)
Date: Tue, 5 Nov 2002 17:17:25 -0800 (PST)
Cc: pbadari@us.ibm.com (Badari Pulavarty), linux-aio@kvack.org,
       linux-kernel@vger.kernel.org (lkml), bcrl@redhat.com
In-Reply-To: <3DC86C20.7BA743F1@digeo.com> from "Andrew Morton" at Nov 05, 2002 04:10:56 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Badari Pulavarty wrote:
> > 
> > Hi,
> > 
> > Here is (part 1/2) 2.5.46 patch to support AIO for raw/O_DIRECT.
> > 
> > This patch adds the infrastructure only. It does not make
> > DIO code Async. (part 2/2 does). Here is summary of what this
> > patch does:
> > 
> > 1) Adds generic_file_aio_write_nolock() and makes all other
> >    generic_file_*_write() to use it.
> > 
> > 2) Modifies generic_file_direct_IO() and ->direct_IO() functions
> >    to take "kiocb *" instead of "file *".
> > 
> > 3) Renames generic_direct_IO() to blockdev_direct_IO().
> >         (Andrew's suggestion)
> > 
> > 4) Moves generic_file_direct_IO() to mm/filemap.c
> >         (Andrew's suggestion)
> > 
> > 5) Adds AIO read/write support for raw driver.
> > 
> 
> Looks sane.  Did nfs_direct_IO() not need updating?

Comment in nfs_direct_IO() says it is broken and it fails
to compile. So I did not update it. May be I should ..

- Badari
