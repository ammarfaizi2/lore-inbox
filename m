Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUGSIwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUGSIwV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 04:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUGSIwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 04:52:20 -0400
Received: from fmr05.intel.com ([134.134.136.6]:3456 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S264270AbUGSIwJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 04:52:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Kernel oops while shutting down (2.6.8rc1)
Date: Mon, 19 Jul 2004 16:51:33 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD5606@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel oops while shutting down (2.6.8rc1)
Thread-Index: AcRtagwd+yr6+Up1RI6pcDxM82V2CwAAWWwA
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Mark Watts" <m.watts@eris.qinetiq.com>,
       "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Jul 2004 08:51:34.0533 (UTC) FILETIME=[982F8350:01C46D6D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Watts wrote:

>> One of those driver modules probably has a function in the cleanup
>> routine path unloaded/unmapped. Doing a cat /proc/modules before
>> shutting down and taking copying the output would help speed up the
>> search. 
> 
> $ /sbin/lsmod
> Module                  Size  Used by
...
> processor              17032  1 thermal

This is the root cause. See http://bugme.osdl.org/show_bug.cgi?id=1716,
there is also a fix patch available.

Thanks,
-yi
