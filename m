Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTHBM7T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 08:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTHBM7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 08:59:19 -0400
Received: from [217.157.19.70] ([217.157.19.70]:28430 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S262577AbTHBM7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 08:59:18 -0400
Date: Sat, 2 Aug 2003 14:59:16 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (2.4.2x) Driver for Medley software RAID (Silicon Image
 3112 SATARaid, CMD680, etc?) for testing
In-Reply-To: <Pine.LNX.4.40.0308012225130.29551-100000@jehova.dsm.dk>
Message-ID: <Pine.LNX.4.40.0308021446080.30871-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In response to some early feedback:

If you test this driver and it doesn't work, please include the output
from dmesg in your bug report (trace is enabled by default).

If it does work, currently it is logging 2 lines for each request, which
means it will be pretty slow if you are using syslogd/klogd.

So when your array is detected and you can mount a partition, please
remove this excessive trace by removing the following line from
drivers/ide/raid/medley.c:

#define DEBUGGING_MEDLEY 0

It is not enough to set the value to 0 you need to remove or comment out
that line altogether to remove the trace (my mistake).

I will post minor updates to the driver on http://infowares.com/linux

// Thomas

