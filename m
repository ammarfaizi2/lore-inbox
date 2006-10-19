Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946666AbWJSX0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946666AbWJSX0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946646AbWJSX0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:26:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:17323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1946666AbWJSX0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:26:45 -0400
Date: Thu, 19 Oct 2006 16:26:16 -0700
From: Greg KH <greg@kroah.com>
To: Avi Kivity <avi@qumranet.com>
Cc: John Stoffel <john@stoffel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
Message-ID: <20061019232616.GA4876@kroah.com>
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com> <17719.35854.477605.398170@smtp.charter.net> <45378F08.5090204@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45378F08.5090204@qumranet.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 04:43:20PM +0200, Avi Kivity wrote:
> John Stoffel wrote:
> >Avi> This patch defines a bunch of ioctl()s on /dev/kvm.  The ioctl()s
> >Avi> allow adding memory to a virtual machine, adding a virtual cpu to
> >Avi> a virtual machine (at most one at this time), transferring
> >Avi> control to the virtual cpu, and querying about guest pages
> >Avi> changed by the virtual machine.
> >
> >Yuck.  ioclts are deprecated, you should be using /sysfs instead for
> >stuff like this, or configfs.  
> >  
> 
> I need to pass small amounts of data back and forth very efficiently.  
> sysfs and configfs are more for one-time admin stuff, not for continuous 
> device control.

I agree, sysfs or configfs is not for what you are wanting to do here.

thanks,

greg k-h
