Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWFARIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWFARIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWFARIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:08:09 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:7438 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964909AbWFARII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:08:08 -0400
Date: Thu, 1 Jun 2006 13:08:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: liontooth@cogweb.net, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
In-Reply-To: <20060601095913.06200806.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0606011302420.5730-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006, Andrew Morton wrote:

> On Thu, 1 Jun 2006 10:58:43 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > As an alternative, we could allow an "over-budget window" of say 10%.  
> 
> That, plus we should provide a suitable i-know-what-im-doing user override,
> with the appropriate warnings, as well as a printk which directs users to
> this option when we decided to disable their device.

The user override already exists, as do the appropriate warnings.  Daniel 
Drake just added a printk explaining why the device was not configured, 
although it doesn't tell how to configure the device by hand.  Perhaps a 
FAQ entry at www.linux-usb.org would be appropriate.

> The power supply spec is a conservative minimum, whereas the device spec is
> a worst-case maximum.  One would expect a lot of devices will work OK when
> run "out of spec".
> 
> (Goes away and pats all his 240V plugpacks which are happily working off 110V).

They probably will.  The question is, how far out-of-spec should the 
kernel allow by default?  200% is likely to be too far (your plugpacks 
notwithstanding).

Alan Stern

