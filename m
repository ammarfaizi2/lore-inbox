Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbSLSG34>; Thu, 19 Dec 2002 01:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbSLSG34>; Thu, 19 Dec 2002 01:29:56 -0500
Received: from pby.osdl.jp ([202.221.206.21]:35969 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S267524AbSLSG3y>;
	Thu, 19 Dec 2002 01:29:54 -0500
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
From: "Timothy D. Witham" <wookie@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <200212181908.gBIJ82M03155@devserv.devel.redhat.com>
References: <200212181908.gBIJ82M03155@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Sourcre Development Lab, Inc
Message-Id: <1040276082.1476.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 21:34:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Related thought:

  One of the things that we are trying to do is to automate 
patch testing.

  The PLM (www.osdl.org/plm) takes every patch that it gets
and does a quick "Does it compile test".  Right now there
are only 4 kernel configuration files that we try but we are
going to be adding more.  We could expand this to 100's 
if needed as it would just be a matter of adding additional
hardware to make the compiles go faster in parallel.

  Here is the example of the output from a baseline kernel.

http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=986

  A patch would look the same.  The PASS reports are really
short and the FAIL reports just give you the configuration 
files and the tail of the output from the kernel make.

 We've talked to a couple of system vendors about expanding
this to take the configurations that have passed and running
them on their 10's of hardware platforms of interest and we 
would be very happy to expand this to a very large number of
configurations of all sorts.

Tim

On Wed, 2002-12-18 at 11:08, Alan Cox wrote:
> > And I think it could work for the kernel too, especially the stable
> > releases and for the process of getting there. I just don't really know
> > how to set it up well.
> 
> A start might be
> 
> 1.	Ack large patches you don't want with "Not for 2.6" instead
> 	of ignoring them. I'm bored of seeing the 18th resend of 
> 	this and that wildly bogus patch. 
> 
> 	Then people know the status
> 
> 2.	Apply patches only after they have been approved by the maintainer
> 	of that code area.
> 
> 	Where it is core code run it past Andrew, Al and other people
> 	with extremely good taste.
> 
> 3.	Anything which changes core stuff and needs new tools, setup
> 	etc please just say NO to for now. Modules was a mistake (hindsight
> 	I grant is a great thing), but its done. We don't want any more
> 
> 
> 4.	Violate 1-3 when appropriate as always, but preferably not to
> 	often and after consulting the good taste department 8)
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham <wookie@osdl.org>
Open Sourcre Development Lab, Inc
