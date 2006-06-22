Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWFVQ0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWFVQ0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030646AbWFVQ0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:26:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030645AbWFVQ0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:26:13 -0400
Date: Thu, 22 Jun 2006 09:25:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org, stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-Id: <20060622092506.da2a8bf4.akpm@osdl.org>
In-Reply-To: <20060622160403.GB2539@slug>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<4499BE99.6010508@gmail.com>
	<20060621221445.GB3798@inferi.kami.home>
	<20060622061905.GD15834@kroah.com>
	<20060622004648.f1912e34.akpm@osdl.org>
	<20060622160403.GB2539@slug>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 18:04:03 +0200
Frederik Deweerdt <deweerdt@free.fr> wrote:

> Thu, Jun 22, 2006 at 12:46:48AM -0700, Andrew Morton wrote:
> > I can bisect it if we're stuck, but that'll require beer or something.
> 
> FWIW, my laptop (Dell D610) gave the following results:
> 2.6.17-mm1: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
> 2.6.17+origin.patch: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16

So it's in mainline already - hence it's some recently-written thing which
was not tested in rc6-mm2.

> 2.6.17: oops
> 2.6.17.1: oops

2.6.17 wasn't supposed to oops.  Do you have details on this?

> 2.6.17-rc6-mm2: suspends correctly

Good kernel, that.
