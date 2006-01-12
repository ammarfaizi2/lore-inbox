Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWALPtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWALPtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWALPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:49:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:28901 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751400AbWALPtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:49:08 -0500
Message-ID: <43C67A6E.3060708@us.ibm.com>
Date: Thu, 12 Jan 2006 09:49:02 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com,
       "Mike D. Day" <ncmike@us.ibm.com>, Greg KH <greg@kroah.com>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>	 <43C5A199.1080708@us.ibm.com>	 <1137029574.11331.11.camel@localhost.localdomain>	 <00466d4b0eb7fe1603cd7f54448d37ff@cl.cam.ac.uk>	 <1137078863.5397.15.camel@localhost.localdomain>	 <5ae8261aff3d780b6594683c1d118bbd@cl.cam.ac.uk> <1137080242.5397.37.camel@localhost.localdomain>
In-Reply-To: <1137080242.5397.37.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>The ppc64 hypervisor does something like this today in a couple of
>places.  It is kinda a mess.  I think that putting a generic, binary
>firmware interface leads to having a bit of a crutch.  It basically lets
>the userspace software stack bypass Linux and talk directly to the
>hypervisor.  It also means that you have to have a very specialized
>software stack for each hypervisor or virtualization type, which is very
>bad.
>
>This pushes things out to userspace, which is generally good.  But, it
>is pushing behavior and "hardware" knowledge out there, too.  The
>hardware knowledge, especially, is something that we usually try to
>encapsulate.
>  
>
The Xen virtual hardware is exposed in the normal way (there is a Xen 
bus so Xen devices show up under that).

>Also things like inter-partition page sharing, and partition migration
>are used in other hypervisors.  I think it is essential to get common
>interfaces to those things.
>  
>
In very, very different ways though.

>One last thing...  When you say "very strongly binary" do you mean, "are
>implemented now as very strongly binary", or "absolutely 100% have to be
>horribly strongly binary"?  They are two quite different things. :)
>  
>
To expose the hypercalls to userspace via sysfs (or another high level 
interface) would require a whole bunch of complex code to encode the 
hypercalls and decode there results.  I'm not sure having a common 
interface is a compelling argument to justify this kernel-level 
complexity since one can just standardize on a userspace library 
(something like http://www.libvir.org).

I do agree we need a common interface though...

Regards,

Anthony Liguori

>-- Dave
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

