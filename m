Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbUJXRwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbUJXRwt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 13:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUJXRwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 13:52:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:44423 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261570AbUJXRuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 13:50:01 -0400
Subject: Re: [PATCH] PCI fixes for 2.6.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041022234508.GA28380@kroah.com>
References: <10982257353682@kroah.com> <10982257352301@kroah.com>
	 <20041020091045.D1047@flint.arm.linux.org.uk>
	 <20041022234508.GA28380@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098636436.24301.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 24 Oct 2004 17:47:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-23 at 00:45, Greg KH wrote:
> > It's not that the driver is buggy.  It's that the driver has far
> > more information than the PCI layer could ever have.
> 
> Ugh, I hate broken hardware.  I'll revert this in my next round of pci
> changes (sometime next week.)

It isnt always broken hardware either. You have no idea at the core
level how the internals are configured. Thus for example if a device
provides both legacy and non-legacy ports disabling it can do horrible
things on pci unregister (eg soundcards with legacy joystick mappings)

As to video, well we don't always have an owner for video but unloading
frame buffers doesn't want to turn the video card off either..

