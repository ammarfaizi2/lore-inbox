Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUH0X3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUH0X3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUH0X1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:27:39 -0400
Received: from ruby.getonit.net.au ([210.8.120.221]:32208 "EHLO
	ruby.getonit.net.au") by vger.kernel.org with ESMTP id S267170AbUH0XYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:24:51 -0400
From: "Tim Warnock" <timoid@getonit.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: More than 2048 ptys on 2.4.27
Date: Sat, 28 Aug 2004 09:24:47 +1000
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA4+E3P43380+sBshf1RHa98KAAAAQAAAAQtYYqknGzU6+CzMBqc9FPgEAAAAA@getonit.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcSMjQsUtaA0ilozQAO1tkwqpMgdZA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Im trying to increase ptys from 2048 to 4096 by doing these things:

Modifying include/linux/major.h:
Increase major numbers to 16
Move slave major start to 231 (according to docs this is available for use)

This appears to work to the point that the kernel doesn't panic on boot (ive
had some fun before now ;) however when an application tries to allocate a
pty I get an: "inappropriate ioctl for device"

As a test I lowered major numbers to 4, set ptys to 1024 and put slave major
start to 138 (should have been 136) and I didn't get this error.

So my question is how do I allow the use of major numbers 231 through to 247
as pty slaves and major numbers 136-144 as pty masters?

