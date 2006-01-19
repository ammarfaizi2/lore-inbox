Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161316AbWASEyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbWASEyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWASEyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:54:20 -0500
Received: from [202.125.80.34] ([202.125.80.34]:14520 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1161316AbWASEyU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:54:20 -0500
Subject: RE: clarity on kref needed.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 19 Jan 2006 10:15:51 +0530
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B28BF0D@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: clarity on kref needed.
Thread-Index: AcYcRpDHdUSOgkDkQ7eskyc9TqpDpgAa/ORA
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I have gone through kref and am planning to implement then 
> in my usb driver.
> 
> What kind of usb driver?
It is a finger print authentication USB driver. it doesn ot do the authgentication but transports data to the application which really does some processing.

No, I did not find any Documentation/kref.txt.
But I have read about kred in the link below:
http://developer.osdl.org/dev/robustmutexes/src/fusyn.hg/Documentation/kref.txt

Is kref depricated because I find nothing related to it in linux/Documentation/?

Thanks & Regards,
Mukund Jampala
> 
> > please terminate my misconceptions if any by correcting the 
> statements below.
> > 
> > In the call below:
> > kref_init(&dev->kref);
> > 	sets the refcount in the kref to 1.
> 
> Yes.
> 
> > kref_put(&dev->kref);
> > 	increment the refcount.
> 
> Hm, don't you mean "kref_get()" here?  If so, yes, that is correct.
> 
> > kref_put(&dev->kref, mem_release );
> > What I understand is when the refcount falls back to '1', only then
> > the mem_release() function will be called.
> 
> No, when it falls to 0 it will be called.
> 
> > Is it correct? I mean, when is the mem_release () called 
> i.e. when the
> > refcount is '0' or '1'.
> 
> 0.  There's an OLS paper from a few years ago that describes kref in
> detail, as well as the in-kernel documentation of it (see the file
> Documentation/kref.txt).  Did you read that?
> 
> thanks,
> 
> greg k-h
> 
