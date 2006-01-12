Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWALPUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWALPUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWALPUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:20:21 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:14034 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1030448AbWALPUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:20:20 -0500
In-Reply-To: <1137078863.5397.15.camel@localhost.localdomain>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <1137029574.11331.11.camel@localhost.localdomain> <00466d4b0eb7fe1603cd7f54448d37ff@cl.cam.ac.uk> <1137078863.5397.15.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5ae8261aff3d780b6594683c1d118bbd@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com,
       "Mike D. Day" <ncmike@us.ibm.com>, Greg KH <greg@kroah.com>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
Date: Thu, 12 Jan 2006 15:26:13 +0000
To: Dave Hansen <haveblue@us.ibm.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Jan 2006, at 15:14, Dave Hansen wrote:

>> This is a good set of questions. We have about half dozen files in
>> /proc/xen right now. One is an obvious canididate to stick in /dev, as
>> it has primarily an ioctl() interface.
>
> Actually, anything with an ioctl interface is probably a good cantidate
> for a writable sysfs file.  The basic idea is that we prefer something
> in sysfs with a discrete, unique name.  It also makes it a lot easier 
> to
> develop with because you can look at the values from scripts, and you
> don't have to worry about synchronizing any headers.
>
> So, what kind of ioctls are we talking about?

They are pretty low level. e.g., pass-thru a raw hypercall direct to 
xen, map another VM's pages into my address space (given a list of page 
frames), etc. very strongly binary, and unlikely to be useful for 
scripting.

  -- Keir

