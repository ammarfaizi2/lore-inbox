Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132673AbRDGQCY>; Sat, 7 Apr 2001 12:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132675AbRDGQCN>; Sat, 7 Apr 2001 12:02:13 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:35335 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132674AbRDGQCD>; Sat, 7 Apr 2001 12:02:03 -0400
Message-Id: <200104071601.f37G18s88014@aslan.scsiguy.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx 6.1.10 breaks 2.4.3-ac3 
In-Reply-To: Your message of "Sat, 07 Apr 2001 16:28:35 +0200."
             <20010407162835.A18620@werewolf.able.es> 
Date: Sat, 07 Apr 2001 10:01:08 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi.
>
>Subject says it all.
>
>With latest updates, i just deleted the kernel aic7xxx subtree, put instead
>the updated (from people.freebsd.org) tree, and built. All went fine
>until (and including) 6.1.9.

That's not a sufficient way to upgrade.  The tar files are there for
people who are porting the driver to other platforms.  You should always
use the patches to upgrade as they often touch other portions of the
Linux kernel that need fixes in order to work correctly with the
aic7xxx driver.

>6.1.10 just stops after the init messages and stays there forever.

To be expected as you didn't apply the patch to scsi_lib.c that makes
scsi_unblock_host() actually run the device queues to start the system
back up again.

I'm working on an html page for my site that should explain all of
the upgrade proceedures.

--
Justin
