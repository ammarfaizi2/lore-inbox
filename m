Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUGRJbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUGRJbK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 05:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUGRJbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 05:31:10 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:43185 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S263204AbUGRJbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 05:31:03 -0400
Message-ID: <40FA4328.4060304@travellingkiwi.com>
Date: Sun, 18 Jul 2004 10:30:16 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide-cs using 100% CPU
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a thinkpad r50p, 1.6GHz CPU, 512MB memory running kernel 
2.6.7-mm4 (Also tried 2.6.7, 2.6.6, 2.6.4 and a few others).

When reading from CF card (using ide-cs) the system is really stodgy and 
consumes 100% CPU. Almost all of it waitIO according to top...

Now it's not the fact that I get lots of waitIO, but AFAIUI if a system 
uses truckloads of waitIO, that should just mean that the system is idle 
but there's some IO going on & a process is waiting for it to complete 
(e.g. the way AIX does it).

Other processes should still be able to get CPU without any problems, 
but my experience is that under Linux if waitio is due to reading the CF 
card, the system essentially stops... The mouse still moves (Under X), 
but... unwillingly... Jerking around all over the place...

Anyone know why this happens? Something busy waiting? (BUt that should 
show as system cpu right?) or something taking out really long locks?
