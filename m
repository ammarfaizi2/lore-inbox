Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268638AbUHLR6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268638AbUHLR6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268639AbUHLR6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:58:42 -0400
Received: from mail.xor.ch ([212.55.210.163]:27661 "HELO mail.xor.ch")
	by vger.kernel.org with SMTP id S268638AbUHLR6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:58:40 -0400
Message-ID: <411BAFCA.92217D16@orpatec.ch>
Date: Thu, 12 Aug 2004 19:58:33 +0200
From: Otto Wyss <otto.wyss@orpatec.ch>
Reply-To: otto.wyss@orpatec.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: New concept of ext3 disk checks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just read about "Increasing ext3 Disk Checks In The Event Of
Improper Shutdown" in Kernel-Traffic. Since in theory journalling file
systems may prevent any disk corruption the disk checks from the ext2
area doesn't make much sense anymore. Also more and more system don't
boot regularly anymore so the time frame between check isn't
predictable. To take into account that the practice not always behaves
as the theory says, I suggest another concept for ext3 disk checks:

- Instead of checks forced during startup checks are done during runtime
(at low priority). It has to be determined if these checks are _only_
checks or if they also include possible fixes. Possible solution might
distinct between the severity of any discovered problem.

The advantage of such a concept are rather obvious, desktop systems
don't have to use ridiculous high check interval values or disable
checks altogether and server systems may run forever. Also checks may be
done first on the written disk sectors. On an average loaded system,
this way malfunctioning software are detected within minutes and
hardware possibly within days, a rather high improvement to the current
detection time of sometimes months.

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"
