Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUCDB2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUCDB2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:28:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:32943 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261375AbUCDB2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:28:23 -0500
Date: Wed, 3 Mar 2004 17:28:13 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <edt@aei.ca>, Michael Weiser <michael@weiser.dinsnail.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040304012813.GD2207@kroah.com>
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net> <200403030722.17632.edt@aei.ca> <20040303151433.GC25687@kroah.com> <20040304012233.GB22511@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304012233.GB22511@wonderland.linux.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 02:22:33AM +0100, Marco d'Itri wrote:
> On Mar 03, Greg KH <greg@kroah.com> wrote:
> 
>  >Users need to learn that the kernel is changing models from one which
>  >automatically loaded modules when userspace tried to access the device,
>  >to one where the proper modules are loaded when the hardware is found.
> This does not solve the problem of drivers which do not have matching
> hardware, like PPP and loop device. I do not mind unconditionally loading
> these modules at boot, but there has to be a way to recognize them: I do
> not think it is acceptable to load *all* modules available on the system
> (what is the point of having a modular kernel then?).

Then have your "use the loop device" or "use the ppp device" load the
module before it is used.  Or manually create the dev node and hope that
kmod and its aliases work...

thanks,

greg k-h
