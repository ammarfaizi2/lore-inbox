Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVLWAEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVLWAEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVLWAEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:04:34 -0500
Received: from bay16-f6.bay16.hotmail.com ([65.54.186.56]:44566 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751163AbVLWAEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:04:33 -0500
Message-ID: <BAY16-F62AE23D265EDA3F940115AF330@phx.gbl>
X-Originating-IP: [203.166.111.194]
X-Originating-Email: [alexshinkin@hotmail.com]
From: "Alexey Shinkin" <alexshinkin@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: questions on wait_event ...
Date: Fri, 23 Dec 2005 06:04:33 +0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 23 Dec 2005 00:04:33.0226 (UTC) FILETIME=[740C7AA0:01C60754]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi , all !
Could anyone please clarify one thing in that old well known
wait_event_... code (taken from 2.6.5 wait.h ):

#define __wait_event_interruptible(wq, condition, ret)          \
do {                                                                    \
        wait_queue_t __wait;                                     \
        init_waitqueue_entry(&__wait, current);           \
                                                                        \
        add_wait_queue(&wq, &__wait);                   \
        for (;;) {                                                      \
                set_current_state(TASK_INTERRUPTIBLE);    \
                if (condition)                                          \
                        break;
........................................

Is it possible that scheduling happen after set_current_state() but before
checking the condition ?
If yes - even if we will have condition==TRUE by this moment - the scheduler
will make the process to sleep anyway , right ?

Regards
Alex Shinkin

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

