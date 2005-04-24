Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVDXV7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVDXV7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVDXV7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:59:04 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:50051 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262453AbVDXV6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:58:39 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Ed Tomlinson <tomlins@cam.org>, Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
Date: Sun, 24 Apr 2005 21:58:38 +0000
Message-Id: <042420052158.11058.426C168D000E9AD100002B32220075115000009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't tried to reproduce it since it will cause me data loss :(
I am not sure it is possible to go to this extent in order to reproduce
the reboot but still... Here is what I was doing when the error occured -
I installed Ubuntu AMD64 5.04 release. Installed 2.6.12-rc3.
Installed and configured a chroot env for 32bit programs. (dchroot) 
Installed 32bit JRE from Sun - latest one. Tried to install 
Borland Together J Eclipse edition under the chrooted environment 
- Just before the install finished, machine rebooted. Machine was 
running for couple hours before the reboot.

Parag


> On Sunday 24 April 2005 04:41, Alexander Nyberg wrote:
> > sön 2005-04-24 klockan 00:08 -0400 skrev Parag Warudkar:
> > > While running a 32 bit Java program 2.6.12-rc3 rebooted spontaneously 
> leaving 
> > > a corrupt partition table and disk with errors. There was nothing in dmesg 
> > > (no oops/panic) except some -MARK- entries during the reboot.
> > > 
> > 
> > Is this reproducible? If so, can you give a detailed description of how.
> 
> I think rc3 has code from rc2-mm2/3.  Both of these reboot here randomly.  
> Nothing
> shows up on a serial console...  Think something is seriously wrong with x86_64 
> in rc3.
> That being said its possible its fixed in HEAD by.
> 
> [PATCH] x86_64: fix new out of line put_user()
> [PATCH] x86_64: Bug in new out of line put_user()
> 
> some people have reported reversing (in -mm)
> 
> sched-unlocked-context-switches.patch
> 
> Helps too.
> 
> Ed Tomlinson
