Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTLJSTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 13:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTLJSTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 13:19:52 -0500
Received: from ida.rowland.org ([192.131.102.52]:10756 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263886AbTLJSTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 13:19:50 -0500
Date: Wed, 10 Dec 2003 13:19:49 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312101854.44636.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312101318330.850-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Duncan Sands wrote:

> On Wednesday 10 December 2003 18:34, David Brownell wrote:
> > > Unfortunately, usb_physical_reset_device calls usb_set_configuration
> > > which takes dev->serialize.
> >
> > Not since late August it doesn't ...
> 
> In current 2.5 bitkeeper it does.

I don't understand the problem.  What's wrong with dropping dev->serialize 
before calling usb_reset_device() or usb_set_configuration() and then 
reacquiring it afterward?

Alan Stern

