Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161382AbWJKVBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161382AbWJKVBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161379AbWJKVBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:01:42 -0400
Received: from cantor.suse.de ([195.135.220.2]:27013 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161376AbWJKVBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:01:41 -0400
Date: Wed, 11 Oct 2006 14:01:37 -0700
From: Greg KH <gregkh@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Pavel Machek <pavel@suse.cz>,
       Paolo Abeni <paolo.abeni@email.it>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] usbmon: add binary interface
Message-ID: <20061011210137.GA16427@suse.de>
References: <20061011134351.0c79445a.zaitcev@redhat.com> <Pine.LNX.4.44L0.0610111649440.6437-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610111649440.6437-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 04:51:09PM -0400, Alan Stern wrote:
> On Wed, 11 Oct 2006, Pete Zaitcev wrote:
> 
> > On Wed, 11 Oct 2006 19:44:43 +0000, Pavel Machek <pavel@suse.cz> wrote:
> > 
> > > Does it mean text interface is now deprecated? Or perhaps ioctl should
> > > be added to text interface too? Or maybe we do not need binary
> > > interface if we allow resizing on text interface?
> > 
> > I haven't reviewed Paolo's patch yet, but with that in mind:
> >  - No, text is not deprecated yet. That is only possible when a simplified
> >    command-line tool is written and distributed (e.g. usbmon(8)).
> >  - No, I do not think an ioctl in debugfs or a text API is a good idea.
> >  - Resizing on text interface magnifies sprintf contribution to CPU burn,
> >    so once we have the binary one, there's only disadvantage and
> >    no advantage in implementing that.
> 
> Would relayfs be a better choice than debugfs for exporting potentially
> large quantities of binary data?

You can put relayfs files in debugfs.  Or at least that was the goal a
long time ago, hopefully it still works...

thanks,

greg k-h
