Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVIZEX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVIZEX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 00:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVIZEX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 00:23:26 -0400
Received: from cnxtsmtp9.conexant.com ([198.62.9.206]:48143 "EHLO
	nbmime1.bbnet.ad") by vger.kernel.org with ESMTP id S932367AbVIZEX0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 00:23:26 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: schedule_work returns FAILURE (0)
Date: Mon, 26 Sep 2005 09:54:16 +0530
Message-ID: <4D6E93075B31154298572E6B73CA849D02339170@noida-mail.bbnet.ad>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: schedule_work returns FAILURE (0)
Thread-Index: AcXCUigxtgSrsSHUSA+hY31BSHKZyw==
From: "Ravi Dubey" <ravi.dubey@conexant.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Sep 2005 04:24:21.0860 (UTC) 
    FILETIME=[2B3F4240:01C5C252]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have ported my USB driver on from Linux Kernel 2.4.20-8 to 2.6.11.12.
As a part of this porting process, I have replaced the bottom halves
with work_queues. Now, I am facing problems in the driver execution.
:-(.

The schedule_work() function which schedules the work is returning
FAILURE (0) many times (at least 1 out of 4 times it is called).

My queries:

1. When a work is queued using schedule_work (), does the function (that
is to be called as bottom half) run at process context OR Interrupt
context - The reason why I am getting confused is that in this called
function, if I print the return value of in_interrupt (), I get 0 (which
means that is running at process context), However, if I print the value
of in_interrupt after I have acquired a spin lock in this function, I
get the value 256 (which means I am running in interrupt context) ?

2. Why is the schedule_work () function failing. - I can't use
flush_workqueue in interrupt context, so is there any way; I can force
the work in the work queue to be scheduled.

Best Regards
Ravi





********************** Legal Disclaimer ****************************
"This email may contain confidential and privileged material for the sole use of the intended recipient.  Any unauthorized review, use or distribution by others is strictly prohibited.  If you have received the message in error, please advise the sender by reply email and delete the message. Thank you."
**********************************************************************

