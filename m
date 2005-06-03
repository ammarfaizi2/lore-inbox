Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVFCSEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVFCSEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVFCSEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:04:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:35498 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261426AbVFCSD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:03:57 -0400
Date: Fri, 3 Jun 2005 11:03:36 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Message-ID: <20050603180336.GA5502@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3A5@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3A5@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 08:30:44AM -0500, Abhay_Salunke@Dell.com wrote:
> 
> 
> > 
> > No no no.  Just because you are using the firmware interface, does not
> > mean you need to add this extra round-trip to the whole system.  Just
> > dump the firmware to the /sys/firmware/whatever... file whenever you
> > want to, that's all that is needed.  No hotplug stuff, no filename
> > stuff, just a simple copy.
> Greg, all the feedback gave the impression that request_firmwae hotplug
> stuff was the way to go.

It is the way to go.

> Seems it's not required!

Not at all, why do you think I mean that?

> Now that means it needs to be done the way it was before except that
> it needs to have a bin attribute for data and a normal attribute for
> size.  This would be even better as it makes it easy to read back the
> data.

No, you can still use the firmware core code, that's what it is there
for.  But don't mess with the "make the user provide a filename" stuff.
Just have your driver create the firmware request and then relax.  Your
code will get called when the firware is written to, right?  That's all
you need.

What's with this obsession about firmware filenames... :)

thanks,

greg k-h
