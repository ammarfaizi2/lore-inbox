Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276894AbRKSOwN>; Mon, 19 Nov 2001 09:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277012AbRKSOwE>; Mon, 19 Nov 2001 09:52:04 -0500
Received: from fungus.teststation.com ([212.32.186.211]:28688 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S276894AbRKSOvn>; Mon, 19 Nov 2001 09:51:43 -0500
Date: Mon, 19 Nov 2001 15:51:02 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: <dalecki@evision.ag>
cc: Sven Vermeulen <sven.vermeulen@rug.ac.be>,
        Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: /sbin/mount and /proc/mounts difference
In-Reply-To: <3BF8D576.D03A0EB6@evision-ventures.com>
Message-ID: <Pine.LNX.4.30.0111191120270.16168-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Martin Dalecki wrote:

> Urban Widmark wrote:
> > 
> > mount writes everything to /etc/mtab and displays that when asked.
> 
> Not quite...
> 
> ~/tmp# strings /bin/mount | grep mounts
> Note that one does not really mount a device, one mounts
> /proc/mounts
> ~/tmp#

Not sure what you are trying to show with that grep ...

# strace mount |& grep mounts
# strace mount |& grep mtab
open("/etc/mtab", O_RDONLY)             = 3

mount does read /etc/mtab for displaying the mounts. It only looks at
/proc/mounts if /etc/mtab can't be read. Or at least, that is what the
version(s) I have does. I would say that the common setup is to have a
readable mtab.

/Urban

