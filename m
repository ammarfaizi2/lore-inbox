Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWIOMGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWIOMGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 08:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWIOMGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 08:06:16 -0400
Received: from tinc.cathedrallabs.org ([72.9.252.66]:10126 "EHLO
	tinc.cathedrallabs.org") by vger.kernel.org with ESMTP
	id S1751318AbWIOMGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 08:06:16 -0400
Date: Fri, 15 Sep 2006 09:03:57 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] 8250: remove not needed NMI watchdog tickle in serial8250_console_write()
Message-ID: <20060915120357.GB6642@cathedrallabs.org>
References: <20060913205203.GC4787@cathedrallabs.org> <20060914214210.9128e032.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914214210.9128e032.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Pyzor-Results: Reported 0 times.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I disagree.
> 
> If characters are flowing out at a rate which consistently exceeds
> one-per-ten-milliseconds, the touch_nmi_watchdog() in wait_for_xmitr() will
> never be called.
> 
> Consequently a large interrupt-time write to the serial port (ie: sysrq-T
> with serial-console enabled) will cause the NMI watchdog to trigger.
> 
> No?
gah, you're right. please drop this one.
Thanks,

-- 
Aristeu

