Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275336AbTHGNz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275332AbTHGNz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:55:27 -0400
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:33153 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S275359AbTHGNzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:55:22 -0400
From: jlnance@unity.ncsu.edu
Date: Thu, 7 Aug 2003 09:55:22 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Tests
Message-ID: <20030807135522.GA5460@ncsu.edu>
References: <3F306858.1040202@mrs.umn.edu> <20030805224152.528f2244.akpm@osdl.org> <3F310B6D.6010608@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F310B6D.6010608@namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 06:06:37PM +0400, Hans Reiser wrote:
> 
> I don't think ext2 is a serious option for servers of the sort that 
> Linux specializes in, which is probably why he didn't measure it.

FWIW, I use Linux to run an application which generates many large
temporary files.  Some larger runs could easily generate hundreds
of GB of on-disk data.  I really prefer to use ext2 for these temp
files.  The speed is nice, and the data consistency guarantees the
other FSes give me does not really mean much as most of the files
are not of any use if the machine were to crash.  Fsck times on
an unclean shutdown are a problem, but I guess I could solve that
by running mkext2fs instead.

On my home machine I switched the partition I do mozilla development
on from ext3 back to ext2.  The man reason being that "make clobber"
was so much faster.  And again I feel comfortable doing this because
I can regenerate everything on that partiton with out too much
work.

Anyway, I just wanted to point out that ext2 still has its uses.  Im
looking forward to trying out reiser4.  The speed looks quite impressive
from what I have seen on the net.

Thanks,

Jim
