Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTJCS1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 14:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263835AbTJCS1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 14:27:36 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:60145 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263834AbTJCS1e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 14:27:34 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: e1000 -> 82540EM on linux 2.6.0-test[45] very slow in one direction
Date: Fri, 3 Oct 2003 11:27:30 -0700
Message-ID: <E3A930D59AFC3345AEBA35189102A8A6193289@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e1000 -> 82540EM on linux 2.6.0-test[45] very slow in one direction
Thread-Index: AcOJmY73Di4fqm7+QR63OlqNHBtI+gAQBTMg
From: "Leech, Christopher" <christopher.leech@intel.com>
To: <ookhoi@humilis.net>
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
X-OriginalArrivalTime: 03 Oct 2003 18:27:30.0996 (UTC) FILETIME=[01A5CF40:01C389DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw, I had to compile the e1000 driver as a module. Compiled in it
> doesn't work, as is stated on the intel support page:

> This is not clear from the kernel config help. A patch against
> 2.6.0-test6 is attached (I don't know how to only give n/m as an
> option).

This patch is not necessary or desired.  The version of e1000 that ships
with the kernel source should work fine statically linked, and the
comment on the Intel support web page applies to the separate download
of the e1000 source.  If you download the driver source from Intel and
do the work to add it into a kernel source tree yourself, Intel customer
support may not help you when you have problems.

If you are having problems compiling in the version of e1000 that ships
with the kernel, please report it on netdev and we'll try and help.
 
> Btw2, can somebody please explain what the option E1000_NAPI does?

NAPI is a network driver polling mode interface.  It enables a form of
software managed interrupt moderation, and may result in better
performance under some traffic patterns (specifically sustained high
packet rate reception).

-- Chris
