Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTJFT5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTJFT5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:57:42 -0400
Received: from mx3.evanzo-server.de ([81.209.142.20]:4747 "EHLO
	mx3.evanzo-server.de") by vger.kernel.org with ESMTP
	id S261649AbTJFT5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:57:41 -0400
From: Markus Schoder <lists@gammarayburst.de>
To: linux-kernel@vger.kernel.org
Subject: kernel panic with 2.6.0-test6-mm4 and nptl
Date: Mon, 6 Oct 2003 21:57:31 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310062157.31805.lists@gammarayburst.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2 out of 3 times I got a kernel panic when running the tst-eintr1
test from current glibc (CVS) and nptl 0.60. It also happens
sometimes during normal usage.

I used all features defined in sysdeps/unix/sysv/linux/kernel-features.h
of glibc.

The message is `Fatal exception in interrupt'.  The stack trace
looked like this (from memory)

do_page_fault+0x0/0x50c
do_page_fault+0x41/0x50c
do_page_fault+0x0/0x50c
error_code+0x2f/0x50c

repeated 100s of times (infinite recursion?).

Machine is an Athlon XP 2000+, 768MB RAM, no modules loaded.

On one occasion I experienced a similar panic with 2.6.0-test6 plain
when using the same glibc but I could not reproduce it.

--
Markus

