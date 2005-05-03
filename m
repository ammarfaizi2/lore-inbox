Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVECDUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVECDUd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 23:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVECDUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 23:20:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:28099 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261334AbVECDU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 23:20:26 -0400
Date: Mon, 2 May 2005 20:18:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2 - /proc/ide/sr0/model: No such file or directory
Message-Id: <20050502201823.0ab02e96.akpm@osdl.org>
In-Reply-To: <20050503031158.GA6917@kroah.com>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<Pine.LNX.4.62.0505010429050.2491@dragon.hyggekrogen.localhost>
	<20050503031158.GA6917@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Sun, May 01, 2005 at 04:32:45AM +0200, Jesper Juhl wrote:
> > On Sat, 30 Apr 2005, Andrew Morton wrote:
> > 
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/
> > > 
> > 
> > I see one small change in behaviour with this kernel.
> > 
> > During boot when initializing udev I see 
> > 
> > Initializing udev dynamic device directory.
> > grep: /proc/ide/sr0/model: No such file or directory
> > grep: /proc/ide/sr1/model: No such file or directory
> > 
> > With previous kernels I only see
> > 
> > Initializing udev dynamic device directory.
> 
> That is because you have a udev script that is expecting to see ide
> stuff in proc.  That has now been moved to sysfs, so you should not need
> to run external scripts to detect ide devices now.  I suggest you go bug
> your distro, or whoever set up those rules about it.

err, we don't want to break existing userspace setups, please.
