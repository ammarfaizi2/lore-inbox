Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUC3Mvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 07:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUC3MvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 07:51:20 -0500
Received: from main.gmane.org ([80.91.224.249]:15512 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263638AbUC3MvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 07:51:18 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Balazs Ree <ree@ree.hu>
Subject: HPT370 locks up (2.4/2.6)
Date: Tue, 30 Mar 2004 14:47:50 +0200
Message-ID: <pan.2004.03.30.12.47.49.242291@ree.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 3e44a42e.adsl.enternet.hu
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know that this issue has been brought up before, but still...

I have an ABIT KT7-RAID motherboard with a HPT370 IDE controller on it.
I have two SAMSUNG SP0802N drives attached, one on each channel, with a
software RAID1 setup.

Under both 2.4.22 and 2.6.4 that I tried, the same thing happens. System
boots up allright, and works for a random period of time. Then it
locks up completely with the disk led stuck lighting. No keystrokes work
and there is no error message that I could see. The crash can be triggered
by disk-intensive operations, it seems however like a random
phenomenon, that but sooner or later happens for sure. It is likely
that the case is connected with DMA handling, and that it only occurs if
both IDE channels are utilized heavily (like is the case with RAID1).

I've read from others having the same symptom on this list, but I could
find no solution so far. None of the suggestions or patches that I tried
have worked out (including the new patch of Andre Hedrick, which has no
effect in this case since the HPT370 is a rev 3. controller) 

However, since my last try in last August with 2.4.22 I was using the
"opensource" driver of HighPoint which worked rock stable for my setup.
Now I started to experiment again with the hpt366 driver, this time under
2.6.4, and it's the same lockup situation. I would be rather happy to see
the hpt366 driver working as then I (and others) would not be forced to
use the "opensource" driver of Highpoint, that, besides being a
partly binary driver, has other disadvantages (like it needs initrd, and
it does not support S.M.A.R.T., or compile yet with the 2.6 kernel)

In case someone has any idea, I would be glad to send specific logs and/or
test patches (preferably with 2.6.4).

-- 
Balazs REE


