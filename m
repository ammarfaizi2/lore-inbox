Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUIOVb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUIOVb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUIOV3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:29:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:43695 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267507AbUIOVX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:23:58 -0400
Date: Wed, 15 Sep 2004 14:23:22 -0700
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Robert Love <rml@novell.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915212322.GB25840@kroah.com>
References: <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com> <1095279043.23385.102.camel@betsy.boston.ximian.com> <20040915202234.GA18242@hockin.org> <1095279985.23385.104.camel@betsy.boston.ximian.com> <20040915203133.GA18812@hockin.org> <1095280414.23385.108.camel@betsy.boston.ximian.com> <20040915204754.GA19625@hockin.org> <1095281358.23385.109.camel@betsy.boston.ximian.com> <20040915205643.GA19875@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915205643.GA19875@hockin.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 01:56:43PM -0700, Tim Hockin wrote:
> On Wed, Sep 15, 2004 at 04:49:18PM -0400, Robert Love wrote:
> > On Wed, 2004-09-15 at 13:47 -0700, Tim Hockin wrote:
> > 
> > > Are you not sending it with some specific device as the source?  Or is it
> > > just coming from some abstract root kobject?
> > 
> > It comes the the physical device.
> > 
> > Is there really a specific issue that you are seeing?
> 
> Well, two.
> 
> 1) If you send me an event "/dev/hda3 mounted", but it was for some other
> namespace, you just leaked potentially useful information.

No, we are sending an event that says:
	block/hda/hda3 was mounted.

Now it's up to you, in your namespace to figure out where sysfs is
mounted, and then what, if any /dev device corrisponds to that sysfs
block device (using udevinfo in your namespace if you so desire.)

We aren't giving absolute /dev entries here, that's the beauty of the
kobject tree :)

thanks,

greg k-h
