Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTIWSVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTIWSVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:21:47 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:16617 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S262141AbTIWSVp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:21:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: NS83820 2.6.0-test5 driver seems unstable on IA64
Date: Tue, 23 Sep 2003 11:21:35 -0700
Message-ID: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: NS83820 2.6.0-test5 driver seems unstable on IA64
Thread-Index: AcOB/BMzzNsMP/LRTN+4sSDTmxCzzgAAcnUA
From: "Luck, Tony" <tony.luck@intel.com>
To: "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>
Cc: <davidm@napali.hpl.hp.com>, <peter@chubb.wattle.id.au>, <bcrl@kvack.org>,
       <ak@suse.de>, <iod00d@hp.com>, <peterc@gelato.unsw.edu.au>,
       <linux-ns83820@kvack.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Sep 2003 18:21:36.0303 (UTC) FILETIME=[861A73F0:01C381FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I understand it, you even do this stupid printk for user apps
> as well, that makes it more than rediculious.  I'd be surprised
> if anyone can find any useful kernel messages on an ia64 system
> in the dmesg output with all the unaligned access crap there.

I don't think that it is "normal" for applications to do unaligned
memory access.  It means that:

a) the programmer is playing fast and loose with types and/or casts.
b) the end-user is going to be disappointed with the performance.

Looking at a couple of ia64 build servers here I see zero unaligned
access messages in the logs.

-Tony
