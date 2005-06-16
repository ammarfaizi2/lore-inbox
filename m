Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVFPPtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVFPPtV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 11:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVFPPtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 11:49:20 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:60107 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261695AbVFPPtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 11:49:15 -0400
Message-ID: <42B19F65.6000102@nortel.com>
Date: Thu, 16 Jun 2005 09:48:53 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Patrik_H=E4gglund?= <patrik.hagglund@bredband.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: SCHED_RR/SCHED_FIFO and kernel threads?
References: <42B199FF.5010705@bredband.net>
In-Reply-To: <42B199FF.5010705@bredband.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrik Hägglund wrote:

> Kernel threads seems to generally be scheduled in the SCHED_OTHER class 
> (with the 'migration' thread as an exception).

This is on purpose.  The idea is that realtime processes get all the 
time they request.  If the kernel threads are interrupting the realtime 
app, then the latency of the realtime app is degraded.

> As I see it, "kernel activity" shall not be starved by user-space 
> processes. Therefore, I was very suprised by this behaviour when I saw 
> it in 2.6.11.

If you want specific kernel threads to take priority, you can always 
manually make then SCHED_RR/SCHED_FIFO yourself.

Chris
