Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUH0RMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUH0RMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUH0RMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:12:24 -0400
Received: from gl177a.glassen.ac ([82.182.223.101]:35591 "HELO findus.dhs.org")
	by vger.kernel.org with SMTP id S266687AbUH0RMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:12:21 -0400
Message-ID: <412F6B74.5090806@findus.dhs.org>
Date: Fri, 27 Aug 2004 19:12:20 +0200
From: =?ISO-8859-1?Q?Petter_Sundl=F6f?= <petter.sundlof@findus.dhs.org>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040825)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Voluntary Preempt P9 againstclean  2.6.8.1 -- on AMD64, compile failure
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Debian-AMD64
Applied
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
to a clean 2.6.8.1 (simply copied over my old .config). Patching went
fine. Using gcc 3.3.4.

   CC      kernel/hardirq.o
kernel/hardirq.c: In function `recalculate_desc_flags':
kernel/hardirq.c:309: error: `SA_NODELAY' undeclared (first use in this
function)
kernel/hardirq.c:309: error: (Each undeclared identifier is reported
only once
kernel/hardirq.c:309: error: for each function it appears in.)
kernel/hardirq.c: In function `generic_setup_irq':
kernel/hardirq.c:339: error: `SA_NODELAY' undeclared (first use in this
function)
kernel/hardirq.c: In function `threaded_read_proc':
kernel/hardirq.c:641: error: `SA_NODELAY' undeclared (first use in this
function)
kernel/hardirq.c: In function `threaded_write_proc':
kernel/hardirq.c:659: error: `SA_NODELAY' undeclared (first use in this
function)
make[2]: *** [kernel/hardirq.o] Error 1
make[1]: *** [kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.8.1'
make: *** [stamp-build] Error 2

Clean 2.6.8.1, patched with 2.6.8.1

Had to set CONFIG_VOLUNTARY_PREEMPT=y / CONFIG_PREEMPT_VOLUNTARY=y
manually in .config. I talked to a guy who said it was there in his
"menuconfig". For me the option didn't appear.

Here's my .config: http://findus.dhs.org/~odd/.config

Any idea?

gcc 3.3.4

Cheers.




