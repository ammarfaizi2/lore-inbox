Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUIFOYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUIFOYu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUIFOYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:24:50 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:36340 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268069AbUIFOYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:24:14 -0400
Message-ID: <35fb2e5904090607241087442d@mail.gmail.com>
Date: Mon, 6 Sep 2004 15:24:11 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: linux-kernel@vger.kernel.org
Subject: xilinx_sysace
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I am doing some work on a board port (Xilinx Virtex II Pro 405D
running 2.4.23) which uses the xilinx_sysace driver on a Xilinx Virtex
II Pro system (not the ML300 board - an inhouse custom thing). The
driver comes in several pieces because Xilinx supply a (rather
unpleasant) HAL which Monta's adapter.c driver code wraps to create a
block device.

The driver works fine for me as a read only device but I'm still
seeing occasional hard locks on writes (looks to be something not
getting io_request_lock at the right moment - currently
investigating). They use a kernel thread which just sits and
compensates for the hardware not being able to signal when it is ready
for a new request - and I think there's a race there.

I looked in to this before but got pulled off to look at some other
more pressing bits, and I want to fix this now. Does anyone else have
problems writing with it though? Of the people I have spoken to about
this most seem to just use System ACE as a configuration device but we
use it for configuration, kernel image, userland, system
settings...etc.

Cheers,

Jon.
