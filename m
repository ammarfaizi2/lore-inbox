Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTEAMmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 08:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbTEAMmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 08:42:05 -0400
Received: from smtp03.web.de ([217.72.192.158]:38418 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261239AbTEAMmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 08:42:05 -0400
Message-ID: <3EB118F9.9030003@web.de>
Date: Thu, 01 May 2003 14:54:17 +0200
From: Michael Hunold <hunold-ml@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3b) Gecko/20030312
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Junfeng Yang <yjf@stanford.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mc@stanford.edu
Subject: Re: [CHECKER] 5 potential user-pointer errors that allow arbitrary
 reads from kernel
References: <Pine.GSO.4.44.0304302131150.22117-100000@elaine24.Stanford.EDU>
In-Reply-To: <Pine.GSO.4.44.0304302131150.22117-100000@elaine24.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Junfeng,

> This is a resend (the previous report was ignored, however I feel that
> these bugs could be severe).

> Please confirm or clarify. Thanks!

> [BUG] proc_dir_entry.write_proc can take tainted inputs.
> av7110_ir_write_proc is assigned to proc_dir_entry.write_proc
> 
> /home/junfeng/linux-2.5.63/drivers/media/dvb/av7110/av7110_ir.c:116:av7110_ir_write_proc:
> ERROR:TAINTED:116:116: passing tainted ptr 'buffer' to __constant_memcpy
> [Callstack:
> /home/junfeng/linux-2.5.63/net/core/pktgen.c:991:av7110_ir_write_proc((tainted
> 1))]

Confirmed. I'll post a patch when I'm back at work again on Monday.

CU
Michael.

