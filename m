Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbTCHQiV>; Sat, 8 Mar 2003 11:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262078AbTCHQiV>; Sat, 8 Mar 2003 11:38:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10294 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262076AbTCHQiU>; Sat, 8 Mar 2003 11:38:20 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
       Chris Dukes <pakrat@www.uk.linux.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
References: <Pine.LNX.4.44.0303081132030.12316-100000@kenzo.iwr.uni-heidelberg.de>
	<m14r6dlu4w.fsf@frodo.biederman.org>
	<20030308161936.C1896@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Mar 2003 09:48:16 -0700
In-Reply-To: <20030308161936.C1896@flint.arm.linux.org.uk>
Message-ID: <m1zno5kdnz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Sat, Mar 08, 2003 at 09:07:11AM -0700, Eric W. Biederman wrote:
> > With a good bootloader it does not much how big your initrd is.  I
> > totally agree that small is good and important.  At the same time
> > ipconfig.c is wrong.  It is great during development and on systems
> > with a single NIC.  But the hard coded policies can be bad for
> > production systems.  Not that hard coded policies are bad in general
> > just the kernel is the wrong place to put them.
> 
> With multi-NIC systems, it is perfectly possible to use ipconfig.c with
> one specific interface.

Sorry.  I expressed that wrong.  It is not multi-NIC that ipconfig.c gets
wrong.  It is multiple DHCP servers.   You just get multiple dhcp
servers when you have multiple NICs.

The policies in ipconfig.c are quite good, they just are not
universally applicable.  But as ipconfig.c is in the kernel it tends
to get used where it is inappropriate.

> ip=:::::eth0:dhcp
> 
> (I haven't actually tried this though.)

I had forgotten about that one, and I believe it helps in some cases.
 
> However, how do you configure your ramdisk via the boot loader to use
> a specific NIC / mount a specific filesystem, etc?

I can change the contents of my ramdisk as easily as I can change
the kernel command line.  For the complex setups just placing
a configuration file in the ramdisk is what seems to work the best
in practice.

Eric
