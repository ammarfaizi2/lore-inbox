Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVCHIPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVCHIPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 03:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVCHIPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 03:15:16 -0500
Received: from sd291.sivit.org ([194.146.225.122]:52628 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261872AbVCHIPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 03:15:09 -0500
Date: Tue, 8 Mar 2005 09:15:08 +0100
From: Luc Saillard <luc@saillard.org>
To: Greg KH <greg@kroah.com>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] Restore PWC driver
Message-ID: <20050308081508.GD31674@sd291.sivit.org>
References: <200503072216.j27MGLqR024373@hera.kernel.org> <20050308052643.GA16222@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308052643.GA16222@kroah.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:26:43PM -0800, Greg KH wrote:
> On Mon, Mar 07, 2005 at 09:49:40PM +0000, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1982.132.4, 2005/03/07 13:49:40-08:00, alan@lxorguk.ukuu.org.uk
> > 
> > 	[PATCH] Restore PWC driver
> > 	
> > 	PWC has a new maintainer (Luc Saillard) and also the various contentious
> > 	binary hooks removed and replaced with reverse engineering work.
> > 	
> > 	Please restore it to the kernel

Hi all,

 thanks for your comments, because this why i've waited for long time when i
post the first version of the driver. I didn't post another patch on the lkml
because i want to fix the v4l2 layer before another round. I want (if
possible) to remove or deprecated a lot of ioctl in favor of sysfs and v4l2
API. Some ugly kmalloc need to be remove (the last thing of the plugins
architecture) and this:
 
> So, who's going to fix up:
> 	- the MAINTAINERS entry
> 	- the coding style
oops (anyone have a vim syntax file for lkml indenting ?)
> 	- drop that unneeded changelog file
already done
> 	- fix the module help text to point to the proper file (or put
> 	  the file in the proper place.)
> 	- get rid of the c++ crud in the header file
> 	- drop the "magic" nonsense
> 	- the ioctls to work on 64bit machines

Can you help me about this 64bits problems ? i've now a amd64 and the webcam
works fine. But perhaps i need to test with a 32 bits app?

Luc
