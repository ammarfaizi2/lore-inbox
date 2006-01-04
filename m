Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWADPcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWADPcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 10:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWADPcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 10:32:08 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:53220 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S1750827AbWADPcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 10:32:07 -0500
Message-ID: <43BBE40E.5040600@wolfmountaingroup.com>
Date: Wed, 04 Jan 2006 08:04:46 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@sgi.com>
Cc: kdb@oss.sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Announce: kdb v4.4 is available for kernel 2.6.15
References: <13550.1136365849@kao2.melbourne.sgi.com>
In-Reply-To: <13550.1136365849@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

I noticed that during page faults, the OOPS handler is not getting
called when the kernel crashes in
filp_open() -- the notifier chain does not return for some reason.  I
also noticed that when this happens, if you the section in 
/arch/i386/kernel/traps.c in function die() prior to the busting of
spinlocks, it will work (sortof work).  To reproduce this error, call 
filp_open with a text string complied in the kernel.  I can reproduce on 
2.6.10 and 2.6.11 Fedora Kernels.   Also noticed that when Kprobes is 
enabled, the debugger page faults during a page fault exeception. 
Seems related to the notifier chain.

If you fixed this already, disregard this notice.

Jeff

