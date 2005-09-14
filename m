Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVINQI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVINQI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVINQI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:08:59 -0400
Received: from peabody.ximian.com ([130.57.169.10]:493 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1030220AbVINQI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:08:58 -0400
Subject: Re: [patch] hdaps driver update.
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: Mr Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050914160527.GA22352@kroah.com>
References: <1126713453.5738.7.camel@molly>
	 <20050914160527.GA22352@kroah.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 12:09:35 -0400
Message-Id: <1126714175.5738.21.camel@molly>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 09:05 -0700, Greg KH wrote:

> Woah, no, this is not ok.  Please see my objections to this the zillion
> other times people have tried to do this...
> 
> Why is this static?  Shouldn't it be dynamic and then your release would
> be able to free the memory?

The release only happens on module unload, the device is not
hotpluggable, and thus we'd gain the memory anyhow.

So it is static the way any other no-need-to-dynamically-create data
structure would be.

No?

> >  static struct device_driver hdaps_driver = {
> >  	.name = "hdaps",
> >  	.bus = &platform_bus_type,
> > -	.owner = THIS_MODULE,
> >  	.probe = hdaps_probe,
> >  	.resume = hdaps_resume
> >  };
> 
> Why delete that?  You just lost your symlink in sysfs then :(

I don't follow.

Wouldn't we want to be removed from sysfs?

	Robert Love


