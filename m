Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWA3TeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWA3TeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWA3TeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:34:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:42204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964910AbWA3TeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:34:02 -0500
Date: Mon, 30 Jan 2006 11:33:08 -0800
From: Greg KH <greg@kroah.com>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Dave Hansen <haveblue@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, "Mike D. Day" <ncmike@us.ibm.com>
Subject: Re: [Xen-devel] Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
Message-ID: <20060130193308.GA18145@kroah.com>
References: <43DAD4DB.4090708@us.ibm.com> <1138637931.19801.101.camel@localhost.localdomain> <43DE45A4.6010808@us.ibm.com> <1138640666.19801.106.camel@localhost.localdomain> <43DE4A1D.4050501@us.ibm.com> <1138642737.22903.14.camel@localhost.localdomain> <26c21a6abef89d4629a0da08bc0ba9bf@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26c21a6abef89d4629a0da08bc0ba9bf@cl.cam.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 05:53:30PM +0000, Keir Fraser wrote:
> 
> On 30 Jan 2006, at 17:38, Dave Hansen wrote:
> 
> >Yes, they are.  Buuuuuuut, you _can_ make the code around them a little
> >less evil.  If you _must_ use a typedef, you could do something like
> >this:
> >
> >#define XEN_CAP_INFO_LEN_BYTES 1024
> >typedef char [XEN_CAP_INFO_LEN_BYTES] xen_capabilities_info_t;
> 
> Is that really better than just referencing the typedef? I've always 
> considered them okay for simple scalar and array types, even if they 
> are to be avoided for structure types. Is it the size aspect that is 
> the problem (e.g., a typedef'ed type should be okay to allocate on the 
> stack)?

No, a typedef for a simple array in the kernel is just foolish.  Please
read the archives and my old OLS paper on coding style as to why
typedefs are not acceptable in the kernel, except for a very few core
types (and you should not be creating those types of objects...)

thanks,

greg k-h
