Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSKKWxC>; Mon, 11 Nov 2002 17:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSKKWxC>; Mon, 11 Nov 2002 17:53:02 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:35334 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261544AbSKKWxB>; Mon, 11 Nov 2002 17:53:01 -0500
Date: Mon, 11 Nov 2002 17:59:42 -0500
From: Ben Collins <bcollins@debian.org>
To: David San?n Baena <davidsanan@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to access user space memory from kernel.
Message-ID: <20021111225942.GB522@phunnypharm.org>
References: <00df01c289d3$52969420$6e9afea9@anabel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00df01c289d3$52969420$6e9afea9@anabel>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 11:40:19PM +0100, David San?n Baena wrote:
> Hi. I need to access to user space memory from a kernel module. This module
> is not a driver, so I would like how can i write and read from/to a variable
> in a user application from my kernel module?
> At first I thought I could do that with shared memory (shmget, shmat...),
> but in that is not possible in a kernel module. So I have thought to do it
> with copy_from_user and copy_to_user, but i don't know how to do it exactly,
> basically how to know where to write or read in the user var...
> Any suggestion???
> Thanks in advance

The user space application will have to make a call to the driver
somehow. Usually this is in the way of an ioctl() on a device that the
driver has made available to use space. The arguments passed across the
ioctl are known to your kernel module and userspace app. You could pass
a pointer to the kernel module which would be userspace memory that the
driver could copy_to_user some data to.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
