Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbTLGDEN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 22:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbTLGDEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 22:04:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:7361 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265293AbTLGDEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 22:04:11 -0500
Date: Sat, 6 Dec 2003 18:58:59 -0800
From: Greg KH <greg@kroah.com>
To: Mike Gorse <mgorse@mgorse.dhs.org>
Cc: Maneesh Soni <maneesh@in.ibm.com>, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: Oops w/sysfs when closing a disconnected usb serial device
Message-ID: <20031207025859.GA28787@kroah.com>
References: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org> <20031201093804.GA6918@in.ibm.com> <Pine.LNX.4.58.0312011849050.9617@mgorse.dhs.org> <20031206013844.GA16844@kroah.com> <Pine.LNX.4.58.0312052102460.13792@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312052102460.13792@mgorse.dhs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 09:16:12PM -0500, Mike Gorse wrote:
> On Fri, 5 Dec 2003, Greg KH wrote:
> 
> > Try the patch below.  With your sysfs patch I don't get any oopses
> > anymore.  I still need to beat on this patch a lot more before I think
> > it solves all of the current issues.  Can you let me know if it works
> > for you or not?
> > 
> I tried it briefly, and it made no difference with the issue I am having.  
> When disconnecting the gps receiver with a fd still open on it, it still 
> gives an oops on closing it without the sysfs patch.  The sysfs patch 
> eliminates the oops, but I wasn't getting an oops without your patch if I 
> include the sysfs patch.  Anyway, I have over 200k of debugging output, so 
> I'll send it to you off list.

Hm, wait.  I mean use your sysfs patch, _and_ my patch.  Previously you
had said your sysfs patch had only moved the oops elsewhere.  I found
that true myself, hence my patch.  With both patches, things work for
me, how about you?

Oh, about all of that debugging output, just enable debugging in the
usbserial core, not the usb serial driver.  That makes it much more
managable :)

thanks,

greg k-h
