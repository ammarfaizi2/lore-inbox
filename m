Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbTHGSdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 14:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270040AbTHGSdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 14:33:32 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:29968
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270007AbTHGSdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 14:33:25 -0400
Date: Thu, 7 Aug 2003 11:33:22 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Patrick McLean <pmclean@cs.ubishops.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interactivity improvements
Message-ID: <20030807183322.GB23303@matchmail.com>
Mail-Followup-To: Patrick McLean <pmclean@cs.ubishops.ca>,
	linux-kernel@vger.kernel.org
References: <3F3261A2.9000405@cs.ubishops.ca> <20030807152418.GA509@malvern.uk.w2k.superh.com> <3F327382.5000200@cs.ubishops.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F327382.5000200@cs.ubishops.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 11:42:58AM -0400, Patrick McLean wrote:
> 
> 
> Richard Curnow wrote:
> >* Patrick McLean <pmclean@cs.ubishops.ca> [2003-08-07]:
> >
> >>Another point is compilers, they tend to do a lot of disk I/O then 
> >>become major CPU hogs, could we have some sort or heuristic that reduces 
> >>the bonuses for sleeping on block I/O rather than other kinds of I/O 
> >>(say pipes and network I/O in the case of X).
> >
> >
> >What about compilers chewing on source files coming in over NFS rather
> >than resident on local block devices?  The network waits need to be
> >broken out into NFS versus other, or UDP versus TCP or something.  e.g.
> >waits due to the user not having typed anything yet, or moved the mouse,
> >are going to be on TCP connections.
> >
> Maybe if we had it reduce sleeping bonuses if it's waiting on filesystem 

We are already doing this.

> access, this would cover NFS as the kernel does consider it a 
> filesystem, this would cover SMB, AFS, etc as well.

Network interactivity is dealing with sockets, and such.  Accessing NFS (and
other network filesystems) deals with a virtual block device, and gives
similar patterns to a local block device.
