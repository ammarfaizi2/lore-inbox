Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSLYV11>; Wed, 25 Dec 2002 16:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSLYV11>; Wed, 25 Dec 2002 16:27:27 -0500
Received: from m83-mp1.cvx2-c.ren.dial.ntli.net ([62.252.152.83]:41717 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S261337AbSLYV11>; Wed, 25 Dec 2002 16:27:27 -0500
Subject: Re: [PATCH] dev_printk macro
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0212221634210.16753-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0212221634210.16753-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Dec 2002 21:34:25 +0000
Message-Id: <1040852066.1109.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-23 at 00:46, Randy.Dunlap wrote:
> 
> Hi LKML,
> 
> I'm glad to see this patch available, as Greg was.
> Now I have some questions about it.
> 
> a.  Is it only for drivers?  If so, why?
>     Filesystems and other subsystems that are not drivers could use
>     something like this also.

Definitely - fs_printk, inode_printk etc may all make sense
> 
> b.  Is it only for drivers that have a device?
>     What does a driver use for dev_printk() if it doesn't have a <dev>?
>     However, these do cover the large majority of cases, so that's good.

This case isnt covered. All devices should eventually have a dev right
8)


