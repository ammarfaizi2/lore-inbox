Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWA3Rri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWA3Rri (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWA3Rri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:47:38 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:28099 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S964839AbWA3Rrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:47:37 -0500
In-Reply-To: <1138642737.22903.14.camel@localhost.localdomain>
References: <43DAD4DB.4090708@us.ibm.com> <1138637931.19801.101.camel@localhost.localdomain> <43DE45A4.6010808@us.ibm.com> <1138640666.19801.106.camel@localhost.localdomain> <43DE4A1D.4050501@us.ibm.com> <1138642737.22903.14.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <26c21a6abef89d4629a0da08bc0ba9bf@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, "Mike D. Day" <ncmike@us.ibm.com>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
Date: Mon, 30 Jan 2006 17:53:30 +0000
To: Dave Hansen <haveblue@us.ibm.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Jan 2006, at 17:38, Dave Hansen wrote:

> Yes, they are.  Buuuuuuut, you _can_ make the code around them a little
> less evil.  If you _must_ use a typedef, you could do something like
> this:
>
> #define XEN_CAP_INFO_LEN_BYTES 1024
> typedef char [XEN_CAP_INFO_LEN_BYTES] xen_capabilities_info_t;

Is that really better than just referencing the typedef? I've always 
considered them okay for simple scalar and array types, even if they 
are to be avoided for structure types. Is it the size aspect that is 
the problem (e.g., a typedef'ed type should be okay to allocate on the 
stack)?

  -- Keir

