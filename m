Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbVKYU3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbVKYU3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 15:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVKYU3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 15:29:32 -0500
Received: from mx1.rowland.org ([192.131.102.7]:56075 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751480AbVKYU3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 15:29:32 -0500
Date: Fri, 25 Nov 2005 15:29:29 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Patrizio Bassi <patrizio.bassi@gmail.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <pavel@ucw.cz>, <shaohua.li@intel.com>, <akpm@osdl.org>
Subject: Re: 2.6.15-rc2-git5 continues to fail suspending (USB issue)
In-Reply-To: <4387621B.20301@gmail.com>
Message-ID: <Pine.LNX.4.44L0.0511251519260.17257-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2005, Patrizio Bassi wrote:

> i tried today's git due to Greg's usb patches,
> but they don't work.
> 
> i wrote already twice the problem:

You wrote about it on lkml, not linux-usb-devel.  So it might not have 
been noticed by the USB developers.

> Stopping tasks: ==========================|
> Freeing memory... done (13146 pages freed)
> usbfs 2-2:1.0: no suspend?
> Could not suspend device 2-2: error -16
> Some devices failed to suspend
> Restarting tasks... done
> 
> If needed i'll reattach the patch i have (against 2.6.14-rc2 iirc)
> 
> lsusb
> Bus 004 Device 001: ID 0000:0000
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 002: ID 0915:8000 GlobeSpan, Inc.
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000

Looks like the vanilla kernel needs to add suspend/resume methods for
usbfs bindings.  What is that GlobeSpan device?  Are you running a
userspace program that controls it?  If you are, you can try quitting that 
program before suspending.

Also, if you haven't tried it, you might want to apply this patch:

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-all-2.6.15-rc2-git3.patch

or whatever is the most current version when you download it.

Alan Stern

