Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbUDFWxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUDFWxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:53:36 -0400
Received: from fmr02.intel.com ([192.55.52.25]:44731 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264053AbUDFWxd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:53:33 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.5, ACPI, suspend and ThinkPad R40
Date: Tue, 6 Apr 2004 18:53:25 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE002F7B6C0@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.5, ACPI, suspend and ThinkPad R40
Thread-Index: AcQcBIqA95Q/ED8KSWao0iTqHUpVqgAIupug
From: "Brown, Len" <len.brown@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
       "Vincent C Jones" <vcjones@NetworkingUnlimited.com>
Cc: <kevin@scrye.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Apr 2004 22:53:25.0778 (UTC) FILETIME=[F845D720:01C41C29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> lack of interest in supporting notebook features

I'm glad that you're complaining about suspend/resume not working.
This means that you were able to boot and configure your system
using ACPI -- a year ago you wouldn't have got so far;-)

Yes, in the past year we've concentrated more on the configuration
issues at the expense of advanced features such as suspend/resume.
While we still have configuration issues, their frequency and
severity is lower than it once was, and so I'm hopeful that
we're over the hump there and will be able to
spend more time on features such as supsend/resume.

When I looked at a suspend/resume failure a couple of weeks ago
I discovered that there is no code in linux to save/restore
PCI configuration space for PCI bridges.  This is sort of a deal
killer -- as bits such as bus-master-enable could come up
enabled or disabled depending on the roll of the dice.
I hoped somebody on linux-pci would send a patch, but I haven't
seen one yet.

Cheers,
-Len
