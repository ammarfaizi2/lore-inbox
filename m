Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWJLRnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWJLRnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWJLRnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:43:47 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:2450 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750993AbWJLRnq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:43:46 -0400
From: Edward Goggin <egoggin@emc.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: looking for explanation of spontaneous reset/reboot on Opteron
Date: Thu, 12 Oct 2006 13:43:15 -0400
Message-ID: <6CCEAEDF4D06984A83F427424F47D6E4013D1446@CORPUSMX40A.corp.emc.com>
In-Reply-To: <6.2.3.4.0.20061012095229.048db398@pop-server.san.rr.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: looking for explanation of spontaneous reset/reboot on Opteron
Thread-Index: AcbuIc6zS+yzBaMfRneS56XQ8NYUDgAAn6pA
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Oct 2006 17:43:16.0002 (UTC) FILETIME=[E59BA020:01C6EE25]
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.10.12.101442
X-PerlMx-Spam: Gauge=, SPAM=2%, Reason='EMC_FROM_0+ -2, __CT 0, __CTE 0, __CTYPE_CHARSET_QUOTED 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __IMS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for information about potential causes for a
spontaneous reboot of a dual core Opteron running RHEL 4
linux (2.6.9 derivative).  I'm thinking the cause is
due to the box taking a triple fault and resetting the
BIOS.

I'm also thinking that the triple fault is caused by a
kernel stack overflow into an unmapped virtual page
frame.  Is this a reasonable explanation?  Are there
others?

What are reasonable debugging strategies for handling
this?  Following the kernel stack overflow hunch, I'm
going to try increasing the Opteron stack size from
8K to 16K.  Can this be done by simply changing
THREAD_ORDER in include/asm-x86_64/page.h from 1 to 2?

Also, is there any kernel stack overflow detection
debugging code anywhere for x86_64 as there is for
i386?

Thanks,

Ed Goggin
