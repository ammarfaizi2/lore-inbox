Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289098AbSAGDRZ>; Sun, 6 Jan 2002 22:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289101AbSAGDRM>; Sun, 6 Jan 2002 22:17:12 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:17925 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289098AbSAGDRE>; Sun, 6 Jan 2002 22:17:04 -0500
Message-ID: <3C3911F1.63E55E90@zip.com.au>
Date: Sun, 06 Jan 2002 19:11:45 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>,
		<3C36DEA9.AEA2A402@zip.com.au>; from akpm@zip.com.au on Sat, Jan 05, 2002 at 03:08:25AM -0800 <20020107034654.G1561@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> I prefer my fix that simply recalls the ->truncate callback if -ENOSPC
> is returned by prepare_write. vmtruncate seems way overkill,

Actually, vmtruncate will trim the page off the inode as well as the
blocks from the file.  I don't think there's necessarily a problem
with having a page wholly outside i_size, but..

-
