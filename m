Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267932AbTBVWHn>; Sat, 22 Feb 2003 17:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267933AbTBVWHn>; Sat, 22 Feb 2003 17:07:43 -0500
Received: from mx5.mail.ru ([194.67.57.15]:47890 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id <S267932AbTBVWHm>;
	Sat, 22 Feb 2003 17:07:42 -0500
Date: Sat, 22 Feb 2003 23:17:19 +0100 (CET)
From: Guennadi Liakhovetski <lyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 146818 RTC set-time curious...
Message-ID: <Pine.LNX.4.44.0302222311560.7720-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Not a bug report, nothing critical (hopefully), just a question - in rtc.c
driver on time-set ioctl() the following is done:
	save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
which writes 0x7X to rtc regs=ister 0xA... Why? I read a few documents and
all agree on, what's expressed in one of them as "bits 4-6 should be 0x2,
other values don't do anything useful on PCs, really..." VERY curious...

Thanks
Guennadi
---
Guennadi Liakhovetski


