Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265529AbSJXQ0l>; Thu, 24 Oct 2002 12:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265531AbSJXQ0l>; Thu, 24 Oct 2002 12:26:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51334 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265529AbSJXQ0k>;
	Thu, 24 Oct 2002 12:26:40 -0400
Date: Thu, 24 Oct 2002 09:35:18 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Mark Peloquin <peloquin@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Switching from IOCTLs to a RAMFS
In-Reply-To: <OFE3B65375.45D5B484-ON85256C5C.005A3AF2@pok.ibm.com>
Message-ID: <Pine.LNX.4.44.0210240931400.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Oct 2002, Mark Peloquin wrote:

> 
> Based on the feedback and comments regarding
> the use of IOCTLs in EVMS, we are switching to
> the more preferred method of using a ram based
> fs. Since we are going through this effort, I
> would like to get it right now, rather than
> having to switch to another ramfs system later
> on. The question I have is:  should we roll our
> own fs, (a.k.a. evmsfs) or should we use sysfs
> for this purpose? My initial thoughts are that
> sysfs should be used. However, recent discussions
> about device mapper have suggested a custom ramfs.
> Which is the *best* choice?

Use sysfs, please. Coming out of the kernel summit, the goal was to move 
as much stuff to a ramfs-based system, rather than ioctl and procfs, and 
Linus explicitly said to try and put them all in the same filesystem. 

	-pat

