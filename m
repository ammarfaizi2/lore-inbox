Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311701AbSDDWCh>; Thu, 4 Apr 2002 17:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSDDWC1>; Thu, 4 Apr 2002 17:02:27 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:20211
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311701AbSDDWCN>; Thu, 4 Apr 2002 17:02:13 -0500
Date: Thu, 4 Apr 2002 14:04:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Raid5 resync slow with one linear array
Message-ID: <20020404220414.GB29089@matchmail.com>
Mail-Followup-To: Mark Cooke <mpc@star.sr.bham.ac.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020403005244.GE952@matchmail.com> <Pine.LNX.4.44.0204042255040.8182-100000@pc24.sr.bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 10:56:02PM +0100, Mark Cooke wrote:
> 
> Hmm,
> 
> Well you have me stumped then, Mike.  I've only been playing with the 
> raid stuff for a little while myself, and haven't had this trouble.
> 
> Hope someone else on the list can help!

I think it is the linear array that is part of the raid5 array.  RAID5
writing to the linear array (because one of the members of the RAID5 is
another linear pair of drives) probably is accounted as normal userspace IO,
and that causes the code to choose a slower transfer rate to sync.

Can someone confirm?
