Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWDOTKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWDOTKy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 15:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWDOTKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 15:10:54 -0400
Received: from smtp-out.google.com ([216.239.45.12]:56603 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751248AbWDOTKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 15:10:53 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=Xp2+0jOIv2+yIWHd2RYo1qidPsQzuRX+y/z961JYAyDnDlF8IJn6qnMilTOMURuHf
	ooyTkMXkVk88PyiInsJyg==
Message-ID: <4441452F.3060009@google.com>
Date: Sat, 15 Apr 2006 12:10:39 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andy Whitcroft <apw@shadowen.org>
Subject: Clear performance regression on reaim7 in 2.6.15-git6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, looking back through the perf results, these two graphs clearly show
a perf regression in reaim7 from 2.6.15 to 2.6.16-rc1. We're loosing 
over 50% of the performance.

http://test.kernel.org/abat/perf/reaim.moe.png
http://test.kernel.org/abat/perf/reaim.elm3b67.png

Drilling down (there's not enough detail on the graphs for releases that
far back), I see it's actually between -git5 and -git6

These are both ia-32 NUMA machines, one is an x440, the other is NUMA-Q.

