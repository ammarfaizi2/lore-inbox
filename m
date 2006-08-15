Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWHONIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWHONIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWHONIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:08:38 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:51364 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965090AbWHONIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:08:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Oops on suspend
Date: Tue, 15 Aug 2006 15:12:49 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <1155603152.3948.4.camel@daplas.org> <200608151153.03441.rjw@sisk.pl> <1155646570.4181.2.camel@daplas.org>
In-Reply-To: <1155646570.4181.2.camel@daplas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151512.49265.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 14:56, Antonino A. Daplas wrote:
> On Tue, 2006-08-15 at 11:53 +0200, Rafael J. Wysocki wrote:
> > On Tuesday 15 August 2006 02:52, Antonino A. Daplas wrote:
> > > Anyone see this oops on suspend to disk? Copied by hand only.
> > > 
> > > EIP is at swap_type_of
> > > 
> > > swsusp_write
> > > pm_suspend_disk
> > > enter_state
> > > state_store
> > > subsys_attr_store
> > > sysfs_write_file
> > > vfs_write
> > > sys_write
> > > sysenter_past_EIP
> > > 
> > > openSUSE-10.2-Alpha3 (2.6.18-rc4), but I see this also with stock
> > > 2.6.18-rc4-mm1.
> > 
> > Are there two swap partitions on your system?  Is any of them on an LVM?
> 
> I have two swap partitions, /dev/hda3 and /dev/hdc1. resume=/dev/hdc1.
> 
> If both partitions are mounted, suspend fails with a message of "cannot
> determined swap partition", or something to that effect.
> 
> If I do swapoff /dev/hda3, then suspend to disk, I get the oops.
> 
> No LVM.
> 
> I'll try removing /dev/hda3 and try again. Hold on...

OK

Could you please try the patch I posted earlier today
(http://marc.theaimsgroup.com/?l=linux-kernel&m=115563697203025&q=raw)?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
