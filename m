Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310305AbSCABsC>; Thu, 28 Feb 2002 20:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310231AbSCABqI>; Thu, 28 Feb 2002 20:46:08 -0500
Received: from [63.204.6.12] ([63.204.6.12]:1942 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S310314AbSCABlP>;
	Thu, 28 Feb 2002 20:41:15 -0500
Date: Thu, 28 Feb 2002 20:40:54 -0500 (EST)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Hua Zhong <hzhong@cisco.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question about running program from a RAM disk
In-Reply-To: <01bc01c1c0a6$a3c315e0$bb3147ab@amer.cisco.com>
Message-ID: <Pine.LNX.4.33.0202282035100.10239-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Hua Zhong wrote:

> In the final system we are going to turn off swap. I had dreamed that Linux
> could directly use the page frame on the RAM disk instead of doing another
> copy :-)

Both ramfs and tmpfs do what you're asking for.  If you are booting
from an initial ramdisk, it's possible to copy the contents of your
ramdisk into a ramfs or tmpfs filesystem at boot time, change roots
with the pivot_root utility, and then throw away the ramdisk.  See
Documentation/initrd.txt for more information on this.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


