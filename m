Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUAHBs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbUAHBs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:48:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:63373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263462AbUAHBs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:48:27 -0500
Date: Wed, 7 Jan 2004 17:48:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <20040107195032.GB823@kroah.com>
Message-ID: <Pine.LNX.4.58.0401071746520.12602@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com>
 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com>
 <Pine.LNX.4.58.0401071123490.12602@home.osdl.org> <20040107195032.GB823@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, Greg KH wrote:
> 
> It sounds like just having the device node around will not cause the
> rescan if you access it.

Who has problems with it, and why?

When you open a partition, that will automatically open the "whole 
device", and that should cause a re-scan if the device supports the "disk 
change" flagging.

This definitely has worked for me. It used to be broken in really early 
2.5.x, but it got fixed with the block device interface fixes.

		Linus
