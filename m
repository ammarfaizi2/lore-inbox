Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbUJ0DAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUJ0DAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUJ0DAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:00:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:41698 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261613AbUJ0DA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:00:29 -0400
Subject: Strange IO behaviour on wakeup from sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 12:56:44 +1000
Message-Id: <1098845804.606.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Not much datas at this point yet, but paulus and I noticed that current
bk (happened already last saturday or so) has a very strange problem
when waking up from sleep (suspend to ram) on our laptops.

This doesn't seem to be directly related to the PM code, at least not
the arch one, as far as I know. The IDE throughput goes down to less
than 100k/sec on hdparm. We haven't yet figured out where the time is
lost, the disk seem to properly be restored to UDMA4 as usual, that code
didn't change for ages, I don't think it's a problem at that level in
IDE.

I'm not sure yet how to track that down, it could be the IO scheduler
getting messed up on wakeup for some reason. Any clue appreciated.

Ben.



