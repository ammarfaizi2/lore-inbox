Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267207AbUBMUvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUBMUvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:51:08 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:56001 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S267207AbUBMUvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:51:06 -0500
Date: Fri, 13 Feb 2004 15:41:30 -0500
From: Ben Collins <bcollins@debian.org>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       greg@kroah.com, Linux-Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] Fix for "Badness in kobject_get" (affected ieee1394)
Message-ID: <20040213204130.GB1648@phunnypharm.org>
References: <20040212145706.GB639@phunnypharm.org> <1076705441.6645.1.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076705441.6645.1.camel@moria.arnor.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 12:50:41PM -0800, Torrey Hoffman wrote:
> On Thu, 2004-02-12 at 06:57, Ben Collins wrote:
> > This seems to have only affected ieee1394 because it uses
> > bus_for_each_dev in a particular (although correct) way.
> [...]
> > ChangeSet@1.1634, 2004-02-12 09:51:06-05:00, bcollins@debian.org
> >   [DRV/BASE]: Put checks in bus_for_each_{dev,drv} to make sure we don't go past the end of the list.
> 
> 
> Thanks, I applied this on top of 2.6.3-rc2-mm1 and it fixed my crash at
> boot problem.  I'll do more extensive testing of the 1394 subsystem
> later today.

After much discussion, Linus put together a cleaner more correct patch
which is in the latest bk.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
