Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270489AbTHGP0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269981AbTHGPZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:25:08 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:50411 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S270386AbTHGPYU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:24:20 -0400
Date: Thu, 7 Aug 2003 16:24:18 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Interactivity improvements
Message-ID: <20030807152418.GA509@malvern.uk.w2k.superh.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F3261A2.9000405@cs.ubishops.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3261A2.9000405@cs.ubishops.ca>
X-OS: Linux 2.6.0-test2-mm4 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 07 Aug 2003 15:24:59.0038 (UTC) FILETIME=[1039E3E0:01C35CF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Patrick McLean <pmclean@cs.ubishops.ca> [2003-08-07]:
> Another point is compilers, they tend to do a lot of disk I/O then 
> become major CPU hogs, could we have some sort or heuristic that reduces 
> the bonuses for sleeping on block I/O rather than other kinds of I/O 
> (say pipes and network I/O in the case of X).

What about compilers chewing on source files coming in over NFS rather
than resident on local block devices?  The network waits need to be
broken out into NFS versus other, or UDP versus TCP or something.  e.g.
waits due to the user not having typed anything yet, or moved the mouse,
are going to be on TCP connections.

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
