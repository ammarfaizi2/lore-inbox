Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264582AbVBFAJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbVBFAJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272109AbVBFAJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:09:07 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:30950 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S272749AbVBFAIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:08:24 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.11-rc[23]: swsusp & usb regression
Date: Sat, 5 Feb 2005 16:08:14 -0800
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
References: <20050204231649.GA1057@elf.ucw.cz> <Pine.LNX.4.44L0.0502051006150.31778-100000@netrider.rowland.org> <20050205231428.GA1098@elf.ucw.cz>
In-Reply-To: <20050205231428.GA1098@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051608.14570.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 February 2005 3:14 pm, Pavel Machek wrote:
> Hi!
> 
> > Your logs don't indicate which host controller driver is bound to each of 
> > your hubs.  /proc/bus/usb/devices will contain that information.  Without 
> > it, it's hard to diagnose what happened.
> 
> I do not think I have any hubs... no external hubs anyway. And I do
> not have /proc/bus/usb/devices file :-(. There's something in
> /sys/bus/usb/devices/.

So what does "lspci -v|grep HCI" say then?

You could try "mount -t usbfs on /proc/bus/usb" ... ;)

Periodically I think that it'd be useful to have the hub driver messages
report the HCD involved, somehow, instead of just "hub", at least when
root hub ports are involved.  It could improve the utility of some bug
reports by a significant amount.

- Dave
