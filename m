Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRCMJYu>; Tue, 13 Mar 2001 04:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbRCMJYj>; Tue, 13 Mar 2001 04:24:39 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:17286 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129712AbRCMJYc>; Tue, 13 Mar 2001 04:24:32 -0500
Date: Tue, 13 Mar 2001 10:22:24 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: named pipe writes on readonly filesystems
Message-ID: <20010313102224.A17224@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <517520000.984449174@tiny> <Pine.GSO.4.21.0103122113480.28460-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0103122113480.28460-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Mar 12, 2001 at 09:15:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2001 at 09:15:33PM -0500, Alexander Viro wrote:
> On Mon, 12 Mar 2001, Chris Mason wrote:
> > Since fs/pipe.c:pipe_write() calls mark_inode_dirty, and it is legal to
> > write to a named pipe on a readonly filesystem, we can end up writing an
> > inode on a readonly FS.
> 
> I would check that in pipe_write()...

So atime and mtime of a named pipe are meaningless in general?
That would make sense, since you cannot access the data anymore,
once they are through the pipe.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
