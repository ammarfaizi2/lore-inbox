Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318270AbSIBKhV>; Mon, 2 Sep 2002 06:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318272AbSIBKhV>; Mon, 2 Sep 2002 06:37:21 -0400
Received: from p508EAA3C.dip.t-dialin.net ([80.142.170.60]:62987 "EHLO
	tigra.home") by vger.kernel.org with ESMTP id <S318270AbSIBKhV>;
	Mon, 2 Sep 2002 06:37:21 -0400
Date: Mon, 2 Sep 2002 12:42:02 +0200
From: Alex Riesen <fork0@users.sf.net>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre1-ac1: Filesystem panic attempting to mount ext3
Message-ID: <20020902104202.GA26326@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <20020901071327.GA404@steel> <20020902113834.E2507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020902113834.E2507@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie, Mon, Sep 02, 2002 12:38:34 +0200:
> Hi,
> 
> On Sun, Sep 01, 2002 at 09:13:27AM +0200, Alex Riesen wrote:
>  
> > the problem appeared on the first partition of an ide
> > IBM-DHEA-36481 with one fat partition on it. I repartioned
> > the device (4 primaries) and "mke2fs -j" three of them.
> > 
> > Than i tried to mount the newly created filesystems and got
> > this in syslog:
> > 
> > Sep  1 08:47:32 steel kernel: FAT: Did not find valid FSINFO signature.
> 
> Which version of e2fsprogs?

mke2fs 1.27 (8-Mar-2002)

> > Assuming that some garbage was left on the disk event after mke2fs,
> > i did "dd if=/dev/zero of=/dev/hdd1 bs=512", which cured the problem,
> > after being followed by mke2fs.
> 
> mke2fs from older versions of e2fsprogs didn't clear out all the
> filesystem and md signatures on a new filesystem.  
> 
> The right way to avoid this is to tell the kernel to mount the fs as
> ext2 or ext3 explicitly, not to rely on the fs-type autodetection in
> mount().

This works, too. Anyway, not an issue anymore

