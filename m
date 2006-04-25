Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWDYGWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWDYGWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 02:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWDYGWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 02:22:31 -0400
Received: from lon-del-01.spheriq.net ([195.46.50.97]:46004 "EHLO
	lon-del-01.spheriq.net") by vger.kernel.org with ESMTP
	id S1751261AbWDYGWa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 02:22:30 -0400
From: Manish RATHI <manish.rathi@st.com>
To: <linux-kernel@vger.kernel.org>
Subject: query regarding serial driver for ARM
Date: Tue, 25 Apr 2006 11:52:13 +0530
Message-ID: <003901c66830$97a4b2b0$802cc70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.5709
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-O-Spoofed: Not Scanned
X-O-General-Status: No
X-O-Spam1-Status: Not Scanned
X-O-Spam2-Status: Not Scanned
X-O-URL-Status: Not Scanned
X-O-Virus1-Status: No
X-O-Virus2-Status: Not Scanned
X-O-Virus3-Status: No
X-O-Virus4-Status: No
X-O-Virus5-Status: Not Scanned
X-O-Image-Status: Not Scanned
X-O-Attach-Status: Not Scanned
X-SpheriQ-Ver: 4.2.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I am loosing characters in serial transfer in case user buffer size is very small. This loss is due to tty buffer overflow.

I am using pl1011 serial driver. Hardware provided hardware flow control (RTS/CTS) based on FIFO thresholds. At the same time software also control the RTS/CTS pins in case of uart_throttle i.e. tty buffer overflow. In my hardware, software control of pins is not possible if it's already done by hardware. So effectilvely uart_throttle() defined in serial driver core framework function has no effect.

Can anybody help me in this regard?

Regards
Manish


