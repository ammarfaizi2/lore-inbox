Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275739AbRJBRCM>; Tue, 2 Oct 2001 13:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275851AbRJBRCC>; Tue, 2 Oct 2001 13:02:02 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:54032 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275739AbRJBRBt>; Tue, 2 Oct 2001 13:01:49 -0400
Message-ID: <3BB9F310.C7CB057@zip.com.au>
Date: Tue, 02 Oct 2001 10:02:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ryan Mack <rmack@mackman.net>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BUG] 2.4.10/0.9.10 "VFS: brelse: Trying to free free buffer"
In-Reply-To: <Pine.LNX.4.33.0110020213100.9833-300000@mackman.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Mack wrote:
> 
> Unfortunately I don't have an oops or a stack trace to report where this
> message came from, but at least maybe this report can alert someone who
> can spot the bug in the code.  This occurred under light usage on an ext3
> partition built on a 2 disk RAID-1 mirrored array.
> 
> The array was either two IDE disks using data-ordered mode or two SCSI
> disks using data-journal mode.
> 

Yes, that shouldn't be happening.  If it is reproducible, could
you please add

	print_buffer_trace(buf);

to the very end of fs/buffer.c:__brelse() and recompile with
CONFIG_BUFFER_TRACE=y?

Thanks.
