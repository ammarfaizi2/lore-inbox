Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTABBl5>; Wed, 1 Jan 2003 20:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbTABBl5>; Wed, 1 Jan 2003 20:41:57 -0500
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:45698 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S265306AbTABBl4>; Wed, 1 Jan 2003 20:41:56 -0500
From: jlnance@unity.ncsu.edu
Date: Wed, 1 Jan 2003 20:50:18 -0500
To: linux-kernel@vger.kernel.org
Subject: Possible module auto-loading problem
Message-ID: <20030102015018.GA14465@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I think I may have found a problem with respect to module
autoloading.  While running the 2.5.53 kernel on a Red Hat 8.0 system,
I tried to automount an ext2 filesystem from a chrooted environment.
The mount failed with a message about ext2 not being supported by the
kernel.  If I try this and the automounter is not running chrooted, then
the module gets autoloaded.
    I must admit that I do not really know how module autoloading works.
I believe that the kernel exec /sbin/modprobe when it thinks it may
need a module.  My theory is that when a chrooted command needs a module
/sbin/modprobe gets run with the chrooted root fs and it cant see the
ext2 module that it needs from there.  I am not sure that this behavior
would be a bug, but I suspect it is something that no one has thought
about.  Could someone shed some light on this?

Thanks,

Jim
