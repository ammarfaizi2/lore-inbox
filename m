Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbRGUIPh>; Sat, 21 Jul 2001 04:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbRGUIP1>; Sat, 21 Jul 2001 04:15:27 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:17683 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267602AbRGUIPR>;
	Sat, 21 Jul 2001 04:15:17 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: ncorbic@sangoma.com
Subject: 2.4.7 net/wanrouter/Makefile, broken SANGOMA
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 21 Jul 2001 18:15:13 +1000
Message-ID: <19579.995703313@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This code in 2.4.7 net/wanrouter/Makefile makes no sense.

obj-m := $(O_TARGET)
ifneq ($(CONFIG_VENDOR_SANGOMA),n)
	obj-m += $(O_TARGET)
endif

obj-m is always $(O_TARGET), adding a second $(O_TARGET) is wrong.
What is CONFIG_VENDOR_SANGOMA trying to do here?

