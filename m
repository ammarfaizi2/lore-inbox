Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966020AbWKJUCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966020AbWKJUCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 15:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbWKJUCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 15:02:40 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:40372 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1753357AbWKJUCj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 15:02:39 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [Fastboot] Kexec with latest kernel fail
Date: Fri, 10 Nov 2006 12:01:33 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071DC@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fastboot] Kexec with latest kernel fail
Thread-Index: AccEiKIXgiVK5zsaTDWPW/ZD39aBzQAeYz/A
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com, "Andi Kleen" <ak@suse.de>
cc: "Horms" <horms@verge.net.au>, "yhlu" <yinghailu@gmail.com>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Nov 2006 20:01:34.0489 (UTC)
 FILETIME=[05DF0090:01C70503]
X-WSS-ID: 694A05141AO1286520-02-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in e820_reserves request_resource for 0xf0000-0xf03ff for reserve and
0xf0400-4G, will return busy with system_rom_resource (0xf0000-0xfffff)
that is put in the resources list by probe_roms,

We need to add back the patch for e820. otherwise all box with old
linuxbios will be broken to get correct in /proc/iomem in x86_64. and
can not use kexec any more.

Comments?

YH


