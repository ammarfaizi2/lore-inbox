Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbTGIW2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268649AbTGIW2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:28:32 -0400
Received: from fmr02.intel.com ([192.55.52.25]:53712 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S268704AbTGIW2a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:28:30 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Redundant memset in AIO read_events
Date: Wed, 9 Jul 2003 15:43:06 -0700
Message-ID: <41F331DBE1178346A6F30D7CF124B24B2A488C@fmsmsx409.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Redundant memset in AIO read_events
Thread-Index: AcNGMqbuKefxMxfKSZKODU7CTu9hFwACKahg
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Dan Kegel" <dank@kegel.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
X-OriginalArrivalTime: 09 Jul 2003 22:43:06.0394 (UTC) FILETIME=[76BB57A0:01C3466B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <newbie>
> There might be some architecture that requires 16 byte alignment...
> how about surrounding the memcpy with 
> if (sizeof(struct io_event) != 4 * sizeof(__u64)) ?
> </newbie>

The point I'm trying to make is that it is irrelevant with respect to
alignment, size, or padding.  memset and struct copying has the same
length and destination address.  Why bother with the memset?  It's the
same as writing a code like this:

blah = 0;
blah = foo;

- Ken
