Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTBGOvQ>; Fri, 7 Feb 2003 09:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTBGOvQ>; Fri, 7 Feb 2003 09:51:16 -0500
Received: from boden.synopsys.com ([204.176.20.19]:26068 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S264925AbTBGOvQ>; Fri, 7 Feb 2003 09:51:16 -0500
Date: Fri, 7 Feb 2003 16:00:38 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       hpa@zytor.com, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] klibc for 2.5.59 bk
Message-ID: <20030207150038.GM5239@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <20030207045919.GA30526@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030207045919.GA30526@kroah.com>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, Fri, Feb 07, 2003 05:59:19 +0100:
> Hi all,
> 
> Thanks to Arnd Bergmann, it looks like the klibc and initramfs code is
> now working.  I've created a patch against Linus's latest bk tree and
> put it at:
> 	http://www.kroah.com/linux/klibc/klibc-2.5.59-2.patch.gz

was the following part of the patch intended? (hello_world?)

 	cpio_mknod("/dev/console", 0600, 0, 0, 'c', 5, 1);
 	cpio_mkdir("/root", 0700, 0, 0);
+	cpio_mkdir("/sbin", 0700, 0, 0);
+	cpio_mkfile("usr/hello_world/hello", "/sbin/hotplug", 0700, 0, 0);
 	cpio_trailer();
 
 	exit(0);


