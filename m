Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUANW31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbUANW31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:29:27 -0500
Received: from fmr06.intel.com ([134.134.136.7]:16606 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264538AbUANW3S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:29:18 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Limit hash table size
Date: Wed, 14 Jan 2004 14:29:12 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB580245B@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Limit hash table size
Thread-Index: AcPZEZIkqALiCxuuTBWhgMb+yXDLRAB19Egg
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 14 Jan 2004 22:29:13.0517 (UTC) FILETIME=[D65F25D0:01C3DAED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> What about making the limit configurable with a boot time
> parameter? If someone uses a 512 GB ppc64 as an nfs server,
> he might want a 2 GB inode hash.

I'm sorry, this code won't have any effect beyond MAX_ORDER defined for
each architecture.  It's not possible to get 2GB hash table on PPC64
since MAX_ORDER is defined at 13 so far for PPC64, which means a 16MB
absolute upper limit enforced by the page allocator.

- Ken
