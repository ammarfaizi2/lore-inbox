Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281569AbRKUFFn>; Wed, 21 Nov 2001 00:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281570AbRKUFFc>; Wed, 21 Nov 2001 00:05:32 -0500
Received: from gear.torque.net ([204.138.244.1]:28175 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S281569AbRKUFFR>;
	Wed, 21 Nov 2001 00:05:17 -0500
Message-ID: <3BFB3566.A74C7A14@torque.net>
Date: Wed, 21 Nov 2001 00:02:30 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mmap-ing __get_free_pages(), order > 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to mmap a scatter gather list to the user space.
[The scatter gather list has the same lifetime as a
file descriptor to a device.] Each element of the scatter 
gather list is obtained from __get_free_pages() 
[typically order == 3].

In LDD2, Rubini & Corbett limit their "scullp" driver
example to order 0. There is a bit of arm waving in
the text (page 392) about some manipulation of page
counts being required when the order is > 0.

Could someone please elaborate what the rules are
(for the "nopage" callback)?
[The DEBUG_LRU_PAGE() at line 206 of page_alloc.c 
disapproves of my attempts to date.]

Is there any driver out there that solves this
particular problem?

Doug Gilbert

