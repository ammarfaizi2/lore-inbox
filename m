Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVBNMgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVBNMgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 07:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVBNMgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 07:36:07 -0500
Received: from magic.adaptec.com ([216.52.22.17]:26854 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261427AbVBNMfz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 07:35:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: aacraid fails under kernel 2.6
Date: Mon, 14 Feb 2005 07:35:52 -0500
Message-ID: <60807403EABEB443939A5A7AA8A7458BC57ED3@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: aacraid fails under kernel 2.6
Thread-Index: AcUSgLN1Qyg8aDaLRYWuldaOPingZQAD5bFw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Jonathan Knight" <jonathan@cs.keele.ac.uk>
Cc: "Mark Haverkamp" <markh@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A significant portion of the operations reside in the Adapter Firmware,
the driver report is essentially telling us the Adapter is locking up.

In the Adaptec branch of the driver there is an AAC_DETAILED_STATUS_INFO
manifest in aacraid.h that would enable firmware prints. The Firmware
that exists in the ROMB occasionally reports conditions via that
channel. The in-box driver has this debug channel turned on by default.
Sometimes this can be used to isolate the condition of failure down.

The logs supplied started with the driver report that the Adapter was
hung, messages prior to that would contain the firmware prints. 

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Jonathan Knight [mailto:jonathan@cs.keele.ac.uk] 
Sent: Monday, February 14, 2005 5:31 AM
To: Salyzyn, Mark
Cc: Jonathan Knight; Mark Haverkamp; linux-kernel
Subject: Re: aacraid fails under kernel 2.6

> Then turn off both read and write cache on the card ...


We've tried with no cache and we had multiple failures over the weekend.
We are running 2.4.20 on some of these boxes and it is stable.  We're
only having problems with the 2.6 kernel.

These systems did stay running for a few hours and then started dying
every
few minutes and then stable again for a few hours.  They are in a air
conditioned machine room with UPS power supplies and we have 11
identical
2500 systems.  Only the ones running 2.6 have issues and those issues
start
the moment 2.6 is installed so we're convinced its software.

What's puzzling me is that the aacraid driver isn't so different between
2.4.20 and 2.6.  Is there a debugging run or something that I can get
that
would help diagnose the problem?



-- 
  ______    jonathan@cs.keele.ac.uk    Jonathan Knight,
    /                                  Department of Computer Science
   / _   __ Telephone: +44 1782 583437 University of Keele, Keele,
(_/ (_) / / Fax      : +44 1782 713082 Staffordshire.  ST5 5BG.  U.K.
