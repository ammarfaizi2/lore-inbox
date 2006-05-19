Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWESOZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWESOZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 10:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWESOZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 10:25:45 -0400
Received: from owa.omneon.com ([12.36.122.13]:43287 "EHLO
	snv-exh1.omneon.local") by vger.kernel.org with ESMTP
	id S932311AbWESOZo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 10:25:44 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8 cards
Date: Fri, 19 May 2006 07:23:04 -0700
Message-ID: <F0E8D0B1F8999D479196DA72521D954A7AD532@snv-exh1.omneon.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8 cards
Thread-Index: AcZ7MeNJNNQLX4aFR4248g89yrlxVQAHdrni
References: <F0E8D0B1F8999D479196DA72521D954A8DA9FF@snv-exh1.omneon.local> <20060519104912.GA16598@favonius>
From: "Michael Robak" <mrobak@Omneon.com>
To: <sander@humilis.net>
Cc: <sander@humilis.net>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried out the 2.6.16.16 kernel yesterday and it seems to have solved my problem.  The signifigant changes to sata_mv make the driver much more stable.  

-Mike
-----Original Message-----
From: Sander [mailto:sander@humilis.net]
Sent: Fri 5/19/2006 3:49 AM
To: Michael Robak
Cc: sander@humilis.net; linux-kernel@vger.kernel.org
Subject: Re: sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8 cards
 
Michael Robak wrote (ao):
> It apears that having multiple bus speeds is not the cause of my issue.
> I was able to get the sata_mv module initalization to hang even when I
> had only 2 cards plugged into both of the 100 MHz slots. This issue is
> extremely difficult to diagnose. Sometimes the sata_mv module will load
> just fine and recognize 24 drives, others it will hang the system during
> intalization, and others it will only fine 23 drives, but the
> initalization completes.
> 
> Any help would be appreciated,

I'm affraid I can't help you much. Mark Lord works on getting the driver
stable on 2.6.16.x kernels. After that he wants to port forward the
changes.

FWIW, there is quite a big libata update which I assume goes into
2.6.17-rc4-mm2. Maybe that helps?

	With kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net

