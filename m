Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTDVIYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTDVIYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:24:47 -0400
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:30710
	"EHLO flat") by vger.kernel.org with ESMTP id S263017AbTDVIYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 04:24:45 -0400
Date: Tue, 22 Apr 2003 09:37:18 +0100
From: cb-lkml@fish.zetnet.co.uk
To: linux-kernel@vger.kernel.org
Subject: [2.5.68-mm1] APM suspend/resume doesn't work properly
Message-ID: <20030422083717.GA604@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I tried 2.5.68-mm1 last night and found that after one suspend/resume cycle the
3c574_cs PCMCIA ethernet card didn't work. The only weirdness in the logs is
Apr 21 17:57:47 flat kernel: eth0: command 0x5800 did not complete!
Apr 21 17:58:18 flat last message repeated 1376 times
which appeared after resuming. Once the card was ejected/reinserted the card
worked fine.

After that the machine would not go into suspend state. 2.5.66-mm3 worked fine.
Didn't try suspend in 2.5.67-mm4.

On the plus side, the 3c574_cs driver fixes seem to work.

Sony Vaio, Celeron 333, Pre-empt, APM, 3c574_cs, Debian sid.

Charlie
