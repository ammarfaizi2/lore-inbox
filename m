Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVLQWys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVLQWys (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 17:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVLQWys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 17:54:48 -0500
Received: from lame.durables.org ([64.81.244.120]:37557 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S964993AbVLQWyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 17:54:47 -0500
Subject: Re: [openib-general] Re: [PATCH 13/13] [RFC] ipath Kconfig and
	Makefile
From: Robert Walsh <rjwalsh@pathscale.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051217215251.GV23349@stusta.de>
References: <200512161548.MdcxE8ZQTy1yj4v1@cisco.com>
	 <200512161548.lokgvLraSGi0enUH@cisco.com>
	 <20051217215251.GV23349@stusta.de>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 14:54:44 -0800
Message-Id: <1134860084.20575.101.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The driver shouldn't use assembler code and therefore no longer depend 
> on X86_64.

Agreed about the assembler, but one way or the other, x86_64 is the only
arch we support.

> -Wall is always set when compiling the kernel.

Fine.

> -O3 doesn't make much sense since the fight for producing the fastest 
> code is between -O2 and -Os.

Makes many nanoseconds of difference to us for our latency numbers.  At
the low latency numbers we measuring (1.29us), this is a very important
difference to our customers.

> You don't want to always compile your driver with -g3.

Good point.  I'll ask around here why we're doing this.

> > +_ipath_idstr:="$$""Id: kernel.org InfiniPath Release 1.1 $$"" $$""Date: $(shell date +%F-%R)"" $$"
> > +EXTRA_CFLAGS += -D_IPATH_IDSTR='$(_ipath_idstr)' -DIPATH_KERN_TYPE=0
> >...
> 
> Please move the _IPATH_IDSTR revision tag to a header file and remove 
> IPATH_KERN_TYPE.

I'll see what I can do.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


