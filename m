Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUEGILT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUEGILT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbUEGILT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:11:19 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:34695 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262361AbUEGILR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:11:17 -0400
Message-ID: <409B4494.5253316B@melbourne.sgi.com>
Date: Fri, 07 May 2004 18:11:00 +1000
From: Greg Banks <gnb@melbourne.sgi.com>
Organization: SGI Australian Software Group
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-6mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Tennert <tennert@science-computing.de>
CC: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>
Subject: Re: PATCH [NFSd] NFSv3/TCP
References: <Pine.LNX.4.44.0405070949160.5549-100000@picard.science-computing.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Tennert wrote:
> 
> As it does not any changes for say a i386 architecture, 

Yes, by design.

> I cannot see why
> after that my lockups should go away.

I don't claim any such thing,  I was just resending a patch (which is of no
use to you) that Neil mentioned had been lost in the shuffle.

> Are lockups no known problem at all? Am I the only one experiencing them?
> They _definitely_ went away for me with NFSSVC_MAXBLKSIZE equal 32k, even
> under high IO pressure.

Sure, I believe you, I just have no idea what your problem is.

As a general statement of no particular import, I note that going to 32K
has a number of other side effects other than the obvious.  For streaming
reads and writes the call rate goes down by a factor of 4 so you may be
not exercising some race condition.  Also there may be different code paths
through READDIR and READDIR+ code.

Now if you had some kind of kernel debugger and could post some more
information, like process list and kernel stack traces from the hang,
someone (not me) may be able to figure out the real problem that you've
hidden by going to 32K.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
