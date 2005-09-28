Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVI1Tks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVI1Tks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVI1Tks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:40:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49640 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750745AbVI1Tkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:40:47 -0400
Date: Wed, 28 Sep 2005 15:40:46 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       <linux-usb-storage@lists.one-eyed-alien.net>
Subject: Re: [linux-usb-devel] RFC drivers/usb/storage/libusual
In-Reply-To: <20050928085159.GA11862@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0509281537070.5193-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Greg KH wrote:

> If so, a few comments.
>   - This only covers the "which module to load" question.  Once the
>     module is loaded, it still always grabs the storage devices, even if
>     another module is loaded later on.  Isn't that still the same issue
>     we have today?  Can't we fix this too?

How about exposing modules' id tables through sysfs and allowing a way 
for entries to be marked valid or invalid?  Then a userspace utility 
program could easily set things up so that normal USB storage devices are 
accepted by usb-storage and not ub, or the other way around.

The part that Pete tackled, arranging the preferences when the modules 
_aren't_ loaded, is actually the harder part.

Alan Stern

