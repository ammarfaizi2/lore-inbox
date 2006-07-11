Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWGKSI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWGKSI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWGKSI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:08:29 -0400
Received: from mail.atl.external.lmco.com ([192.35.37.50]:15504 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S1751170AbWGKSI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:08:28 -0400
Message-ID: <44B3E920.9070907@atl.lmco.com>
Date: Tue, 11 Jul 2006 14:08:32 -0400
From: Jonathan Walsh <jwalsh@atl.lmco.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: "Gautam H. Thaker" <gthaker@atl.lmco.com>, mingo@elte.hu
Subject: RE: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp
 vs. 2.6.12-1.1390_FC4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a follow up to previous emails (Gautam Thaker, Ingo Molnar, Ted Tso, et. al.) on the subject of large CPU overhead by the RT kernel when under heavy network load, I ran the following test in order to get more reasonable data.  I have 19 nodes with 20 "virtual" node processes sending UDP messages to a single host at a rate of 100Hz for 38,000 packets per second.  Using cyclesoak to determine cpu usage (over 240 samples, 1 sample per second), I found the following results:
 
RT kernel: linux-2.6.17-rt1-uni
Mean: 48.9%
Variance: 5.91
Standard Deviation: 2.43
 
Standard kernel: Standard Fedora Core 4
Mean: 23.2%
Variance: 0.237
Standard Deviation: 0.4867
 
Thus I found the average cpu load on the RT kernel to be 2.11 times that of the standard kernel.  Hopefully this information will be of some use.

-Jonathan Walsh
Distributed Processing Lab; Lockheed Martin Adv. Tech. Labs

