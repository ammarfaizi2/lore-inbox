Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUCJNa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 08:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUCJNa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 08:30:57 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:4870 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262605AbUCJNa4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 08:30:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6529.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: per device queues for cciss 2.6.0
Date: Wed, 10 Mar 2004 07:30:22 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF105BC1EBB@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: per device queues for cciss 2.6.0
Thread-Index: AcQGL7lbEWuwRHr9TbeIhG7RX9KsGQAc9vOA
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <axboe@suse.de>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Mar 2004 13:30:54.0913 (UTC) FILETIME=[EA094B10:01C406A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the controller has a single command buffer. It can hold 1024 outstanding commands.

mikem

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Tuesday, March 09, 2004 5:39 PM
To: Miller, Mike (OS Dev)
Cc: axboe@suse.de; akpm@osdl.org; linux-kernel@vger.kernel.org
Subject: Re: per device queues for cciss 2.6.0


Miller, Mike (OS Dev) wrote:
> The command buffer as it is now is per hba. We realize that there may be issues with volumes being starved out but the change was done to make the current driver work with multiple logical volumes. When we move to per logical volume locking scheme we can also implement a per logical volume command structure.

The starvation problem is pretty easy to solve...  see attached.

I was mainly asking about the hardware itself...  does the _hardware_ 
have a single command buffer, or a per-device command buffer?

	Jeff


