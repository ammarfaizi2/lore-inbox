Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUBSUaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267560AbUBSUaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:30:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:42926 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267554AbUBSU3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:29:13 -0500
Date: Thu, 19 Feb 2004 12:28:52 -0800
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: HOWTO use udev to manage /dev
Message-ID: <20040219202852.GB14549@kroah.com>
References: <20040219194610.GB13934@kroah.com> <Pine.LNX.4.44.0402192020100.26894-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402192020100.26894-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 08:21:25PM +0000, James Simmons wrote:
> 
> > udev can create different /dev nodes for these devices.  But as udev
> > does not modify the kernel code at all, it can not "solve" the
> > duplication of numbers in the kernel at all.  Nor is it meant to.
> 
> Okay. If I change the major number of serial ttys inside the kernel 
> of course udev would properly handle this. Now the question is would this 
> break userland applications using the serial port?

Userland apps use /dev names, not major:minor number pairs, right?  So
userspace should be just fine as long as you tell it the proper /dev
name to use.

thanks,

greg k-h
