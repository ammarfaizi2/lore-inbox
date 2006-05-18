Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWERHV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWERHV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWERHV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:21:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:19998 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750809AbWERHV0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:21:26 -0400
X-IronPort-AV: i="4.05,139,1146466800"; 
   d="scan'208"; a="39016839:sNHT18271904"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Over-heating CPU on 2.6.16 with Thinkpad G41
Date: Thu, 18 May 2006 03:21:16 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB679C373@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Over-heating CPU on 2.6.16 with Thinkpad G41
Thread-Index: AcZ6SvQ7Prz5DTWoRtiYNBIAboYoEwAAFSLA
From: "Brown, Len" <len.brown@intel.com>
To: "Steven Rostedt" <rostedt@goodmis.org>, "Pavel Machek" <pavel@ucw.cz>
Cc: "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 May 2006 07:21:17.0640 (UTC) FILETIME=[A7683C80:01C67A4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I have a IBM Thinkpad G41 which has a pentium 4 HT.

This system will have no P-states and no deep C-states,
so the thing to watch is the idle/busy time.  It may be
that something in the patch you applied is keeping the
processor busy 100% and not allowing it to get into
idle (disk wait time that you'll see when building
that kernel counts as idle here) where it can save some power.

-Len
