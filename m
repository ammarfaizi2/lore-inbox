Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVCOA0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVCOA0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVCOAZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:25:28 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:49362 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262110AbVCOAXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:23:06 -0500
Date: Tue, 15 Mar 2005 11:17:39 +1100
From: Nathan Scott <nathans@sgi.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-xfs@oss.sgi.com, mc@cs.Stanford.EDU,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] XFS doesn't respect mount -o sync (XFS, 2.6.11)
Message-ID: <20050315001739.GA1160@frodo>
References: <Pine.GSO.4.44.0503120202580.10379-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0503120202580.10379-100000@elaine24.Stanford.EDU>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 02:14:50AM -0800, Junfeng Yang wrote:
> 
> Hi,
> 
> We are from the Stanford Checker team and are working on a file system
> checker called FiSC.  We checked XFS and found that even when a XFS
> partition is mounted -o sync, file system operations are still not sync'ed
> correctly.

Its -o wsync in XFS.  This is the IRIX way, anyway - from a bit of
man page reading.  We should be stitching that into -o sync a bit
better in XFS.  The combination of -o wsync,sync should get you the
equivalent behaviour at the moment though, I think.

> We are not sure if this is the expected behavior on XFS or not, so your
> inputs on this are well appreciated.

Try using -o wsync for your tests, I'll look into our interpretation
of -o sync in XFS in the meantime.

cheers.

-- 
Nathan
