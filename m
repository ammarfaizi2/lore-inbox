Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266516AbRGQOAr>; Tue, 17 Jul 2001 10:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266518AbRGQOA1>; Tue, 17 Jul 2001 10:00:27 -0400
Received: from joat.prv.ri.meganet.net ([209.213.80.2]:33436 "EHLO
	joat.prv.ri.meganet.net") by vger.kernel.org with ESMTP
	id <S266516AbRGQOAZ>; Tue, 17 Jul 2001 10:00:25 -0400
Message-ID: <3B54454B.97AA34E6@ueidaq.com>
Date: Tue, 17 Jul 2001 10:01:47 -0400
From: Alex Ivchenko <aivchenko@ueidaq.com>
Organization: UEI, Inc.
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.6 possible problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

does anybody use interruptible_sleep_on_timeout(&wqhead, jiffies); under 2.4.6 ?
It seems that after this call sleeping process is never rescheduled again.
Am I doing something wrong in my driver?


<10716>
Knowing that wait queue was reorganized in 2.4 I declared queue head as:

static DECLARE_WAIT_QUEUE_HEAD(wqhead);

and then in ioctl routine

