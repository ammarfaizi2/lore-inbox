Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVAMGeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVAMGeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVAMGeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:34:20 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:46540 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261165AbVAMGeQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:34:16 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] contort getdents64 to pacify gcc-2.96
Date: Wed, 12 Jan 2005 22:34:12 -0800
Message-ID: <DB2C167D8FFDEA45B8FC0B1B75E3EE154A3B15@usca1ex-priv1.sanmateo.corp.akamai.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] contort getdents64 to pacify gcc-2.96
Thread-Index: AcT5Iznd0KMOTPSYTY64WZ0dXmVKOAAEhfjg
From: "Meda, Prasanna" <pmeda@akamai.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Adam Kropelin" <akropel1@rochester.rr.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jan 2005 06:34:13.0677 (UTC) FILETIME=[E5C82DD0:01C4F939]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Linus Torvalds Wrote:

> On Thu, 13 Jan 2005, Adam Kropelin wrote:
> > 
> > ...gives gcc-2.96 indigestion:
>
> Ouch. I wonder what triggers it. But your patch looks fine, so let's just 
> roll with it.

Wierd, It was also okay with 2.95.

Looks like readdir.c had same problems earlier. The post at
http://www.cs.helsinki.fi/linux/linux-kernel/2003-06/0362.html

suggested to change the __put_user to put_user.

Thanks,
Prasanna.
