Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbUKDRyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbUKDRyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbUKDRxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:53:21 -0500
Received: from minimail.digi.com ([204.221.110.13]:2350 "EHLO
	minimail.digi.com") by vger.kernel.org with ESMTP id S262336AbUKDRu7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:50:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: patch for sysfs in the cyclades driver
Date: Thu, 4 Nov 2004 11:50:55 -0600
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E041BF5BC@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: patch for sysfs in the cyclades driver
Thread-Index: AcTClb7nME/4Mv60TLybNWJuzi175wAAKEWw
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Greg KH" <greg@kroah.com>, "Roland Dreier" <roland@topspin.com>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Germano" <germano.barreiro@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > and the implementation in in drivers/scsi/st.c, that there's no
> > problem adding attributes to a device in a simple class.  You can
just
> > use class_set_devdata() on your class_device to set whatever context
> > you need to get back to your internal structures, and then use
> > class_device_create_file() to add the attributes.
> > 
> > I assume this is OK (since there is already one in-kernel driver
doing
> > it), but Greg, can you confirm that it's definitely OK for a driver
to
> > use class_set_devdata() on a class_device from
class_simple_device_add()?

> Hm, I think that should be ok, but I'd make sure to test it before
> verifying that it really is :)

I have just added this code and tested it, and indeed it *does* work!

So I will graciously redraw my comments from my previous email.
It works, and this is definitely the way Germano and I should go in
each of our respective drivers.

Thanks again for everyones comments/help!

Scott Kilau
Digi International


