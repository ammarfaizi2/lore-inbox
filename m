Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbULKCCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbULKCCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 21:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbULKCCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 21:02:21 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:62667 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261909AbULKCCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 21:02:07 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [RFC PATCH] debugfs - yet another in-kernel file system
Date: Fri, 10 Dec 2004 18:02:00 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20041210005055.GA17822@kroah.com> <200412101729.01155.david-b@pacbell.net> <20041211013930.GB12846@kroah.com>
In-Reply-To: <20041211013930.GB12846@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412101802.00197.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 December 2004 5:39 pm, Greg KH wrote:
> > 
> > The problem with sysfs here is:  no seq_file support.
> > Otherwise it solves the basic "where to put the debug
> > files associated with "device X" or "driver Y" problems
> > in a good non-confusing way:  there are directories
> > already set up for devices and for drivers.
> 
> Yes, but that's a design decision for sysfs.  no seq_file support is a
> feature, not a shortcoming :)

It's an arbitrary fiat, sure; not a feature!  ;)


> > What I'd really want out of a debug file API is to resolve
> > the naming issues, work with seq_file, and "softly and
> > silently vanish away".  I think this patch has the last
> > two, but not the first one!
> 
> I considered adding a kobject as a paramater to the debugfs interface.
> The file created would be equal to the path that the kobject has.  Would
> that work for you?

If I could pass device->kobj or driver->kobj, that'd be good.
Will there be a /debug/devices tree parallel to /sys/devices?

- Dave

