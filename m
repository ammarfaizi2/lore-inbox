Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317185AbSFRAPP>; Mon, 17 Jun 2002 20:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317187AbSFRAPO>; Mon, 17 Jun 2002 20:15:14 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:44230 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S317185AbSFRAPM>; Mon, 17 Jun 2002 20:15:12 -0400
Date: Mon, 17 Jun 2002 17:15:13 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 3x slower file reading oddity
In-Reply-To: <3D0E7041.860710CA@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206171649270.18507-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Andrew Morton wrote:

> I rather depends on what is in /tmp/filelist.  I assume it's
> something like the output of `find'.  And I assume you're
> using ext2 or ext3?

yup: find mail1 mail2 -type f -print0 >/tmp/filelist

ext3.

thanks for the description of the block groups... that all makes more
sense now.

> You'll get best throughput with a single read thread.

what if you have a disk array with lots of spindles?  it seems at some
point that you need to give the array or some lower level driver a lot of
i/os to choose from so that it can get better parallelism out of the
hardware.

i see similar slowdowns on a 4-IDE-disk softRAID5+LVM+ext3 setup (SMP
2.4.19-pre7-ac4).  not nearly as bad as on the single disk.

-dean

