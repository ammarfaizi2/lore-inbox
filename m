Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161324AbWJKUvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161324AbWJKUvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161333AbWJKUvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:51:11 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:64527 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161324AbWJKUvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:51:10 -0400
Date: Wed, 11 Oct 2006 16:51:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Pavel Machek <pavel@suse.cz>, <gregkh@suse.de>,
       Paolo Abeni <paolo.abeni@email.it>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] usbmon: add binary interface
In-Reply-To: <20061011134351.0c79445a.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.44L0.0610111649440.6437-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006, Pete Zaitcev wrote:

> On Wed, 11 Oct 2006 19:44:43 +0000, Pavel Machek <pavel@suse.cz> wrote:
> 
> > Does it mean text interface is now deprecated? Or perhaps ioctl should
> > be added to text interface too? Or maybe we do not need binary
> > interface if we allow resizing on text interface?
> 
> I haven't reviewed Paolo's patch yet, but with that in mind:
>  - No, text is not deprecated yet. That is only possible when a simplified
>    command-line tool is written and distributed (e.g. usbmon(8)).
>  - No, I do not think an ioctl in debugfs or a text API is a good idea.
>  - Resizing on text interface magnifies sprintf contribution to CPU burn,
>    so once we have the binary one, there's only disadvantage and
>    no advantage in implementing that.

Would relayfs be a better choice than debugfs for exporting potentially
large quantities of binary data?

Alan Stern

