Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266145AbVBDVwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266145AbVBDVwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbVBDVtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:49:17 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:49912 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264485AbVBDVhd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:37:33 -0500
Subject: Re: [PATCH 1/1] tpm: implement use of sysfs classes
From: Kylene Hall <kjhall@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <20050204205226.GA26780@kroah.com>
References: <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
	 <29495f1d041221085144b08901@mail.gmail.com>
	 <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0502031034290.18135@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0502041405230.22211@jo.austin.ibm.com>
	 <20050204205226.GA26780@kroah.com>
Content-Type: text/plain
Message-Id: <1107553040.22140.30.camel@jo.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Feb 2005 15:37:20 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 14:52, Greg KH wrote:
> On Fri, Feb 04, 2005 at 02:12:50PM -0600, Kylene Hall wrote:
> > +static struct class tpm_class = {
> > +	.name = "tpm",
> > +	.class_dev_attrs = tpm_attrs,
> > +};
> 
> Where is your release function?  Did you see any warnings from the
> kernel when you removed any of these class devices?  Why did you ignore
> it?
> 
Sorry, I missed the warning message.  I have looked at some other
instances for what I might need to put in that function and I'm
stumped.  I didn't kmalloc my class_device structure so I don't need to
kfree it.  I am using this mechanism so that my sysfs stuff is in a
predictable place.  It is also very convient how the driver and device
links as well as all my class specific files get created for me in the
register and likewise removed in the unregister.  I call the register
from the pci probe path and the unregister from the pci remove path. 
What might I need to put in this function?

Thanks,
Kylie

> thanks,
> 
> greg k-h
> 

