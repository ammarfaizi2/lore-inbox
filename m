Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVBSNas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVBSNas (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 08:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVBSNas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 08:30:48 -0500
Received: from fmr15.intel.com ([192.55.52.69]:16527 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261711AbVBSNah convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 08:30:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Should kirqd work on HT?
Date: Sat, 19 Feb 2005 05:30:28 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60040DBACB@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Should kirqd work on HT?
Thread-Index: AcUWY2mFPfASuoXJSkKKmjt0YO5SfQAIsQQg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <ncunningham@cyclades.com>, <kwijibo@zianet.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Feb 2005 13:30:30.0757 (UTC) FILETIME=[2E90E150:01C51687]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You are right. Kernel balancer doesn't move around the irqs, unless it
has too many interrupts. The logic is moving around interrupts all the
time will not be good on caches. So, there is a threshold above which
the balancer start moving things around.

You should see them moving around if you do 'ping -f' or a big 'dd' from
the disk.

Thanks,
Venki 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Nigel 
>Cunningham
>Sent: Saturday, February 19, 2005 1:02 AM
>To: kwijibo@zianet.com
>Cc: Linux Kernel Mailing List
>Subject: Re: Should kirqd work on HT?
>
>Hi.
>
>On Sat, 2005-02-19 at 17:44, Kwijibo wrote:
>> My guess is that irqbalance is not running.
>
>No. It is.
>
>USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
>root       301  0.0  0.0     0    0 ?        SW   16:52   0:00 [kirqd]
>
>The debugging info reports that it doesn't think it's worth doing the
>balancing.
>
>Regards,
>
>Nigel
>-- 
>Nigel Cunningham
>Software Engineer, Canberra, Australia
>http://www.cyclades.com
>
>Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
