Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVLTLKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVLTLKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 06:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVLTLKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 06:10:19 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:19098 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750916AbVLTLKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 06:10:18 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17319.59046.509655.614168@gargle.gargle.HOWL>
Date: Tue, 20 Dec 2005 14:10:30 +0300
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Willy Tarreau <willy@w.ods.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com, axboe@suse.de,
       vandrove@vc.cvut.cz, aia21@cam.ac.uk, akpm@osdl.org
Subject: Re: [RFC] Let non-root users eject their ipods?
Newsgroups: gmane.linux.kernel
In-Reply-To: <2cd57c900512200131l4ff29837o@mail.gmail.com>
References: <1135047119.8407.24.camel@leatherman>
	<20051220051821.GM15993@alpha.home.local>
	<2cd57c900512192206g7292cb1m@mail.gmail.com>
	<20051220085653.GA3137@favonius>
	<2cd57c900512200131l4ff29837o@mail.gmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt writes:
 > 2005/12/20, Sander <sander@humilis.net>:
 > > Coywolf Qi Hunt wrote (ao):

[...]

 > > > IMHO, umount doesn't guarantee sync, isn't it?
 > 
 > Actually I was think umount(2), since this is the kernel list, but off
 > topic here.
 > 
 > >
 > > I'm pretty sure it does :-)
 > 
 > That is because: usually your removable media is not the file system
 > root, hence umount(8) can return successfully only if no processes are
 > busy working on it.
 > 
 > If you boot from or chroot/pivot into a removable media, and you
 > remount it ro, and unplug it, then you may lose data.

sys_umount() writes all cached data back, see generic_shutdown_super()->fsync_super()

 > 
 > -- coywolf

Nikita.
