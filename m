Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131973AbRDQLDa>; Tue, 17 Apr 2001 07:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131887AbRDQLDU>; Tue, 17 Apr 2001 07:03:20 -0400
Received: from quechua.inka.de ([212.227.14.2]:11073 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131973AbRDQLDM>;
	Tue, 17 Apr 2001 07:03:12 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446D9FF@berkeley.gci.com>
Date: Tue, 17 Apr 2001 12:34:55 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14pSox-0000OA-00@hunte.bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Similarly, if my InPackets are at 102345 at one read, and 2345 the
> next read, and I know that my counter is 32 bits, then I know i've
> wrapped and can do my own math.

No. When you have resettable counters, you don't know if the counter
has wrapped or been reset. Either you have received 2345 packets in
between, or 2^32-102345. The difference is not negligible. ;-)

Unless you have a second counter which is incremented with every wrap
(_or_, perhaps better, with every reset) and can _not_ be reset
manually. This would be the date in your date/time example.

Olaf

