Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUJONOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUJONOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUJONOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:14:24 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:57999 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S266905AbUJONOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:14:23 -0400
Message-ID: <416FCD3E.8010605@drzeus.cx>
Date: Fri, 15 Oct 2004 15:14:38 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Tasklet usage?
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My driver needs to spend a lot of time inside the interrupt handler 
(draining a FIFO). I suspect this might cause problems blocking other 
interrupt handlers so I was thinking about moving this into a tasklet.
Not being to familiar with tasklets, a few questions pop up.

* Will a tasklet scheduled from the interrupt handler be executed as 
soon as interrupt handling is done?
* Can tasklets be preempted?
* If a tasklet gets scheduled while running, will it be executed once 
more? (Needed if I get another FIFO interrupt while the tasklet is just 
exiting).

The FIFO is a bit small so time is of the essence. That's why this 
routine is in the interrupt handler to begin with.

Rgds
Pierre Ossman
