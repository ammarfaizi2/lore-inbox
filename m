Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTIWSBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTIWSBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:01:39 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:54284 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S262139AbTIWSBf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:01:35 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: NS83820 2.6.0-test5 driver seems unstable on IA64
Date: Tue, 23 Sep 2003 12:58:59 -0500
Message-ID: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: NS83820 2.6.0-test5 driver seems unstable on IA64
Thread-Index: AcOB+4f+A/scTi+0S7STcJN0vkPsdAAABdwA
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>
Cc: <davidm@napali.hpl.hp.com>, <peter@chubb.wattle.id.au>, <bcrl@kvack.org>,
       <ak@suse.de>, <iod00d@hp.com>, <peterc@gelato.unsw.edu.au>,
       <linux-ns83820@kvack.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Sep 2003 17:59:10.0512 (UTC) FILETIME=[63F30B00:01C381FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The printk() is rate-controlled and doesn't happen for every unaligned
> > access.  It's average cost can be made as low as we want to, by adjusting
> > the rate.
> 
> But if the event is normal, you shouldn't be logging it as if
> it weren't.

That's my view on the fpswa printk's (handle_fpu_swa): they are normal,
expected, and there is absolutely nothing that can be done about them --
so why print a "warning" about them (even if it is only 5 per second)?
If nothing else, toggle the meaning for IA64_THREAD_FPEMU_NOPRINT: turn it
ON for special apps.

Rate-limited unaligned loads in user space make a lot more sense, since
they _may_ point out issues in the code.

Kevin
