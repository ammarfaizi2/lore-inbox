Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267787AbUHEQqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267787AbUHEQqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267788AbUHEQq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:46:29 -0400
Received: from fmr06.intel.com ([134.134.136.7]:22995 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267787AbUHEQqX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:46:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [BROKEN PATCH] kexec for ia64
Date: Thu, 5 Aug 2004 09:45:48 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F01CB2705@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BROKEN PATCH] kexec for ia64
Thread-Index: AcR6P+rBiY2CX8Y0RfWo5Iv0iWtS0QAyuRww
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jesse Barnes" <jbarnes@engr.sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, <khalid.aziz@hp.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-ia64@vger.kernel.org>,
       <fastboot@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Aug 2004 16:45:49.0362 (UTC) FILETIME=[A99B9920:01C47B0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
>With the addition of some ACPI tables and such.  I don't think 
>those are freed by the kernel right now though, so it should
>be pretty easy to point at the originals from the newly kexec'd
>kernel, or make copies.

The "trim_bottom" and "trim_top" functions currently modify
the memory map in place.  But this would only make a difference
if you tried to kexec a kernel with a smaller granule size than
the originally running kernel, and even then would only
result in missing seeing some memory that you might have been
able to use.

-Tony
