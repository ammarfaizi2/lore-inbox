Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293196AbSCGG3w>; Thu, 7 Mar 2002 01:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293482AbSCGG3n>; Thu, 7 Mar 2002 01:29:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20673 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293196AbSCGG3b>;
	Thu, 7 Mar 2002 01:29:31 -0500
Date: Thu, 7 Mar 2002 01:29:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Voluspa <voluspa@bigfoot.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6-pre3 Kernel panic: VFS: Unable to mount root fs on 03:02
In-Reply-To: <20020307072124.6365c8ac.voluspa@bigfoot.com>
Message-ID: <Pine.GSO.4.21.0203070127190.24127-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Mar 2002, Voluspa wrote:

> VFS: Cannot open root device "302" or 03:02

Add
		printk("mount() -> %d\n", err);
right before
                printk ("VFS: Cannot open root device \"%s\" or %s\n",
                        root_device_name, kdevname (ROOT_DEV));
in init/do_mounts.c and see what it prints.

