Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUCaWNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbUCaWNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:13:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:39901 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261703AbUCaWNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:13:52 -0500
Date: Wed, 31 Mar 2004 14:15:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Craig, Dave" <dwcraig@qualcomm.com>
Cc: list@noduck.net, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!
Message-Id: <20040331141558.1dce267c.akpm@osdl.org>
In-Reply-To: <0320111483D8B84AAAB437215BBDA526847F7F@NAEX01.na.qualcomm.com>
References: <0320111483D8B84AAAB437215BBDA526847F7F@NAEX01.na.qualcomm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Craig, Dave" <dwcraig@qualcomm.com> wrote:
>
> Sure thing.
> 
> 7ecb001b A __crc___per_cpu_offset
> c033a510 r __kcrctab___per_cpu_offset
> c033c462 r __kstrtab___per_cpu_offset
> c03366c4 r __ksymtab___per_cpu_offset
> c040bd90 A __per_cpu_end
> c040c020 B __per_cpu_offset
> c04090a0 A __per_cpu_start
> 
> It is a dual processor and the processors are hyperthreaded.

OK.  We're consistently seeing a single-bit difference and there's no
simple power-of-two stride in the things which that pointer points at. 
Most likely you have a hardware problem.
