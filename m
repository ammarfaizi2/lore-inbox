Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbRHFPCw>; Mon, 6 Aug 2001 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRHFPCm>; Mon, 6 Aug 2001 11:02:42 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:7692 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S268765AbRHFPCb>; Mon, 6 Aug 2001 11:02:31 -0400
Date: Mon, 06 Aug 2001 11:02:27 -0400
From: Chris Mason <mason@suse.com>
To: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic
 change patch)
Message-ID: <554880000.997110147@tiny>
In-Reply-To: <20010804100143.A17774@weta.f00f.org>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, August 04, 2001 10:01:43 AM +1200 Chris Wedgwood <cw@f00f.org>
wrote:
 
> Note, there is also a reiserfs fix in here because we can call
> f_op->fsync on a directory and without this fix it will BUG!  Chris,
> perhaps you can suggest a better fix?
> 

Aside from the rest of the discussion on this, did you actually trigger
this BUG for fsync(dir)?  f_op->fsync should already be set to
reiserfs_dir_fsync.

-chris

