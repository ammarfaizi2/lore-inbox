Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbULWQBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbULWQBb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 11:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbULWQBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 11:01:31 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:47823 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S261263AbULWQB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 11:01:29 -0500
Message-ID: <41CAEBD4.8030609@watson.ibm.com>
Date: Thu, 23 Dec 2004 11:01:24 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: noop insert 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In noop-iosched.c (2.6.10-rc2),

void elevator_noop_add_request(request_queue_t *q, struct request *rq,
			       int where)
{
	struct list_head *insert = q->queue_head.prev;

	if (where == ELEVATOR_INSERT_FRONT)
		insert = &q->queue_head;

	list_add_tail(&rq->queuelist, &q->queue_head);
<snip>

shouldn't the insertion happen at insert instead of q->queue_head ?

-- Shailabh
