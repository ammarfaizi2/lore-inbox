Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUBRUHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267999AbUBRUHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:07:24 -0500
Received: from node-402418b2.mdw.onnet.us.uu.net ([64.36.24.178]:241 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S267998AbUBRUHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:07:17 -0500
Date: Wed, 18 Feb 2004 14:04:39 -0600
From: Brandon Low <blow@rbsys.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-ID: <20040218200439.GB449@lostlogicx.com>
References: <20040217232130.61667965.akpm@osdl.org> <40338FE8.60809@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40338FE8.60809@tmr.com>
X-Operating-System: Linux found.lostlogicx.com 2.6.1-mm2
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02/18/04 at 11:16:40 -0500, Bill Davidsen wrote:
> Andrew Morton wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm1/
> >
> >- Added the dm-crypt driver: a crypto layer for device-mapper.
> >
> >  People need to test and use this please.  There is documentation at
> >  http://www.saout.de/misc/dm-crypt/.
> >
> >  We should get this tested and merged up.  We can then remove the nasty
> >  bio remapping code from the loop driver.  This will remove the current
> >  ordering guarantees which the loop driver provides for journalled
> >  filesystems.  ie: ext3 on cryptoloop will no longer be crash-proof.
> >
> >  After that we should remove cryptoloop altogether.
> >
> >  It's a bit late but cyptoloop hasn't been there for long anyway and it
> >  doesn't even work right with highmem systems (that part is fixed in -mm).
> 
> What definition of "stable kernel" do you use which includes removal of 
> features which were reasons to migrate to 2.6 from 2.4? This change 
> would mean having to add dm to the kernel which otherwise doesn't use 
> it, carry dm utilities on the system whcih are otherwise unneeded, and 
> train people to use and not use dm.
> 
> I expect major things to change in a development series, but less major 
> things than this have been pushed to 2.7, why is this being forced in?
>
I must add my voice here in strong opposition of the removal of
cryptoloop from the 2.6 series of kernels.  This is no longer a
development series kernel, I (and others, I'm sure) have been working on
developing technologies which depend on this functionality and which
would be _very_ annoying to do with DM (liveCD-on-cryptoloop-on-iso).

Please do not drop cryptoloop!

Thanks,
--
Brandon Low
Release Coordinator
Ribstone Systems
http://www.ribstonesystems.com
