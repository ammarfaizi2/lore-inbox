Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266100AbUAGSik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbUAGSik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:38:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:41423 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266100AbUAGSii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:38:38 -0500
Date: Wed, 7 Jan 2004 10:38:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <20040103055847.GC5306@kroah.com>
Message-ID: <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Jan 2004, Greg KH wrote:
> 
> Doesn't the kernel always create the main block device for this device?
> If so, udev will catch that.

But udev should probably also create all the sub-nodes if it doesn't 
already.

And it really has to create _all_ of them, exactly because there's no way
to know ahead-of-time which of them will be available.

Then, user space can just access "/dev/sda1" or whatever, and the act of 
accessing it will force the re-scan.

			Linus
