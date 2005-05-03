Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVECDMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVECDMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 23:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVECDMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 23:12:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:17821 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261332AbVECDMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 23:12:13 -0400
Date: Mon, 2 May 2005 20:11:59 -0700
From: Greg KH <greg@kroah.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2 - /proc/ide/sr0/model: No such file or directory
Message-ID: <20050503031158.GA6917@kroah.com>
References: <20050430164303.6538f47c.akpm@osdl.org> <Pine.LNX.4.62.0505010429050.2491@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505010429050.2491@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 04:32:45AM +0200, Jesper Juhl wrote:
> On Sat, 30 Apr 2005, Andrew Morton wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/
> > 
> 
> I see one small change in behaviour with this kernel.
> 
> During boot when initializing udev I see 
> 
> Initializing udev dynamic device directory.
> grep: /proc/ide/sr0/model: No such file or directory
> grep: /proc/ide/sr1/model: No such file or directory
> 
> With previous kernels I only see
> 
> Initializing udev dynamic device directory.

That is because you have a udev script that is expecting to see ide
stuff in proc.  That has now been moved to sysfs, so you should not need
to run external scripts to detect ide devices now.  I suggest you go bug
your distro, or whoever set up those rules about it.

thanks,

greg k-h
