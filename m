Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWBSJrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWBSJrq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 04:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWBSJrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 04:47:46 -0500
Received: from c-66-31-106-233.hsd1.ma.comcast.net ([66.31.106.233]:47544 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S932375AbWBSJrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 04:47:46 -0500
Date: Sun, 19 Feb 2006 04:47:38 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: don't bother users with unimportant messages.
Message-ID: <20060219094738.GA32492@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060219010910.GA18841@redhat.com> <20060219081523.GA9668@flint.arm.linux.org.uk> <20060219082916.GA19903@redhat.com> <20060219093106.GA10010@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219093106.GA10010@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 09:31:06AM +0000, Russell King wrote:
 > On Sun, Feb 19, 2006 at 03:29:16AM -0500, Dave Jones wrote:
 > > On Sun, Feb 19, 2006 at 08:15:23AM +0000, Russell King wrote:
 > >  > On Sat, Feb 18, 2006 at 08:09:10PM -0500, Dave Jones wrote:
 > >  > > When users see these printed to the console, they think
 > >  > > something is wrong.  As it's just informational and something
 > >  > > that only developers care about, lower the printk level.
 > >  > 
 > >  > If you're getting complaints about this, wouldn't it be better to
 > >  > forward them here so that they can be fixed up?
 > > 
 > > w83627hf, and probably other drivers from drivers/hwmon/
 > 
 > I don't see it - w83627hf registers w83627hf_driver via i2c_isa_add_driver,
 > which does not have any probe, remove or shutdown methods.  Moreover,
 > i2c_isa_add_driver doesn't set any of these methods.  So how can:
 > 
 >         if ((drv->bus->probe && drv->probe) ||
 >             (drv->bus->remove && drv->remove) ||
 >             (drv->bus->shutdown && drv->shutdown)) {
 > 
 > be true?

Beats me.  I'll put some printk's in there, and see what falls out.

 > Local distro modifications maybe?

Nope. drivers/hwmon & drivers/i2c is untouched.

		Dave

