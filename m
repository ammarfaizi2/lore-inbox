Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWGaTqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWGaTqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWGaTqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:46:24 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40457 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750904AbWGaTqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:46:23 -0400
Date: Mon, 31 Jul 2006 15:46:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Aleksey Gorelov <dared1st@yahoo.com>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       <gregkh@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] Properly unregister reboot notifier
 in case of failure in ehci hcd
In-Reply-To: <20060731193544.71481.qmail@web81206.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.44L0.0607311542240.8671-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, Aleksey Gorelov wrote:

> > What code duplication?  Doing it the way I suggested doesn't require 
> > adding any new code at all.  You, on the other hand, added several 
> > routines for bus glue that does virtually nothing.
> 
>   But you can not use exactly same shutdown function with both pci and platform glue. You need to
> convert pci/platform device to hcd anyway, right ? So this will add 2 doing 'virtually nothing'
> routines anyway (unless you just want to duplicate the code of shutdown routine for for platform
> glue). For ohci, you would need to do the same, hence 2 more routines, 4 total. With bus glue, I
> added just 2. Am I missing something here ?

Okay, now I understand your point.  Yes, it makes sense to do it your way.

Alan Stern

