Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264988AbTFLUjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbTFLUjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:39:07 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:63633 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264988AbTFLUjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:39:04 -0400
Date: Thu, 12 Jun 2003 15:52:43 -0400
From: Ben Collins <bcollins@debian.org>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Andrew Morton <akpm@digeo.com>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SBP2 hotplug doesn't update /proc/partitions
Message-ID: <20030612195243.GV4695@phunnypharm.org>
References: <1054770509.1198.79.camel@torrey.et.myrio.com> <3EDE870C.1EFA566C@digeo.com> <1054838369.1737.11.camel@torrey.et.myrio.com> <20030605175412.GF625@phunnypharm.org> <1054858724.3519.19.camel@torrey.et.myrio.com> <20030606025721.GJ625@phunnypharm.org> <1055446080.3480.291.camel@torrey.et.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055446080.3480.291.camel@torrey.et.myrio.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:28:00PM -0700, Torrey Hoffman wrote:
> I am now running 2.5.70-bk15, and with slab debugging turned off SBP2
> mostly works.  However, I just had an interesting glitch show up.
> 
> I plugged in a 120 GB drive which had two VFAT partitions, mounted them,
> copied some data to them, unmounted them, and unplugged the drive.  
> That worked perfectly. (This was the first use of SBP2 after booting.)
> 
> Then I plugged in a 250 GB drive with a single reiserfs partition.  The
> SBP2 driver detected the drive correctly, but the kernel's idea of what
> partitions are available was not updated.  
> 
> /proc/partitions still has the old, stale data from the 120 GB drive and
> looks like this: (skipping my hda partitions)

Sounds like the scsi layer is keeping stale info. I'd say this is
suspiciously similar to what's causing your oops in your later email.
Track down where the stale info comes from, and I think you'll find the
cause of both your problems.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
