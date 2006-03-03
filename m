Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWCCU6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWCCU6D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWCCU6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:58:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:14474 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932141AbWCCU6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:58:00 -0500
Date: Fri, 3 Mar 2006 12:32:26 -0800
From: Greg KH <greg@kroah.com>
To: Ren?? Rebe <rene@exactcode.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: MAX_USBFS_BUFFER_SIZE
Message-ID: <20060303203226.GA20250@kroah.com>
References: <200603012116.25869.rene@exactcode.de> <mailman.1141249502.22706.linux-kernel2news@redhat.com> <20060302130519.588b18a2.zaitcev@redhat.com> <200603030827.46003.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603030827.46003.rene@exactcode.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 08:27:45AM +0100, Ren?? Rebe wrote:
> Queueing N = size / 16k URBs in parallel gets the maximal possible thruput with
> the scanner - a 2x speedup. The driver is now even slightly faster than the
> vendor Windows one by about 20%.

That's great.  It's also another data point in the many success storys
saying that Linux's USB stack is faster than Windows, even when driven
by userspace programs :)

> For even further improvements a _async interface would be needed in libusb
> (and sanei_usb) so I can queue the prologue and epilogue URBs of the protocol
> of communication into the kernel and thus elleminate some more wasted time
> slots. I estimate that the driver would then be over 30% faster compared with
> the Windows one.

I'm currently working on a "usbfs2" that will be async-io driven.  That
should allow you to get that added speed you need.

thanks,

greg k-h
