Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbTCOUGT>; Sat, 15 Mar 2003 15:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbTCOUGT>; Sat, 15 Mar 2003 15:06:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:43150 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261504AbTCOUGS>;
	Sat, 15 Mar 2003 15:06:18 -0500
Date: Sat, 15 Mar 2003 12:17:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: "sean darcy" <seandarcy@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-bk9 --  vfat32  fails
Message-Id: <20030315121717.45da96e7.akpm@digeo.com>
In-Reply-To: <F52RDT6Z3LstPGtPrPr000001a9@hotmail.com>
References: <F52RDT6Z3LstPGtPrPr000001a9@hotmail.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 20:17:03.0120 (UTC) FILETIME=[D77ED900:01C2EB2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"sean darcy" <seandarcy@hotmail.com> wrote:
>
> I'm getting this error on a large vfat partition:
> 
> lsattr /win/photo/scanner.test
> lsattr: Inappropriate ioctl for device While reading flags on 
> /win/photo/scanner.test/frame4-atTableSep02.psd
> lsattr: Inappropriate ioctl for device While reading flags on 
> /win/photo/scanner.test/frame2-atTableSep02.psd
> 
> I found this because I couldn't create a soft link (ln -s ) on the 
> partition. FWIW, ls -l does not show a problem.
> 

vfat/msdos/fat filesytems do not support symlinks.

lsattr is an ext2/ext3-specific command.  It dives under the
standard unix/posix interfaces and talks to the filesystem
driver directly.

