Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVCKLjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVCKLjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 06:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVCKLjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 06:39:46 -0500
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:44455 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S262689AbVCKLjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 06:39:00 -0500
X-Antivirus-MYDOMAIN-Mail-From: mohanv@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.0.97):SA:0(-104.9/3.0):. Processed in 1.851976 secs Process 10303)
Message-ID: <423183DE.3020102@aftek.com>
Date: Fri, 11 Mar 2005 17:11:18 +0530
From: Mohan <mohanv@aftek.com>
Reply-To: mohanv@aftek.com
Organization: Aftek Infosys Ltd.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: wait queue sharing..
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I have a question regarding the wait queues. I have a driver
pxausb_core.o which is the core driver which does all USB endpoint
handling and hardware interaction. I have one more driver on top of it
usb-serial which provides for the user-level interaction(like read,
write, ioctl).
I have implemented a blocking ioctl, which sends events about the state
of USB device(enumerated, suspended, disconnected, etc).
For this ioctl, i have declared a wait_queue and initialized (using
init_waitqueue_head() func.) in the usb_ctl.c which is part of
pxausb_core.o. (it has usb_send.c, usb_recv.c, usb_ctl.c, usb_ep0.c).
I am using that wait_queue variable in usb-ser.c.

I just wanted to clarify myself whether the wait queues can be shared
between two driver modules.

Thank you...
regards,
mohan
