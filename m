Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTFLTjG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTFLTjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:39:05 -0400
Received: from codepoet.org ([166.70.99.138]:45967 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264968AbTFLTiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:38:23 -0400
Date: Thu, 12 Jun 2003 13:52:09 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@digeo.com>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SBP2 hotplug doesn't update /proc/partitions
Message-ID: <20030612195209.GA5029@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Torrey Hoffman <thoffman@arnor.net>,
	Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@digeo.com>,
	linux firewire devel <linux1394-devel@lists.sourceforge.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1054770509.1198.79.camel@torrey.et.myrio.com> <3EDE870C.1EFA566C@digeo.com> <1054838369.1737.11.camel@torrey.et.myrio.com> <20030605175412.GF625@phunnypharm.org> <1054858724.3519.19.camel@torrey.et.myrio.com> <20030606025721.GJ625@phunnypharm.org> <1055446080.3480.291.camel@torrey.et.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055446080.3480.291.camel@torrey.et.myrio.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jun 12, 2003 at 12:28:00PM -0700, Torrey Hoffman wrote:
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
> 
> major minor  #blocks  name
> 
>    8     0  117187500 sda
>    8     1   80011701 sda1
>    8     2   37174410 sda2
> 
> fdisk /dev/sda believes the drive is only 120 GB but has a single 250 GB
> partition:

I strongly suspect your 1394 to IDE bridge is an ATA5 device, and
is therefore limited to supporting drives less than 128 GB.  That
is the case for my firewire drives, so I keep them populated with
120 GB drives and I put my 200 GB drives elsewhere....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
