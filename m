Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUEYJaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUEYJaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 05:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbUEYJaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 05:30:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264826AbUEYJaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 05:30:17 -0400
Date: Tue, 25 May 2004 02:29:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-Id: <20040525022941.62ab4cc4.akpm@osdl.org>
In-Reply-To: <20040525103238.GA4212@elte.hu>
References: <20040524062754.GO1833@holomorphy.com>
	<20040524063959.5107.qmail@web90007.mail.scd.yahoo.com>
	<20040524005331.71465614.akpm@osdl.org>
	<20040525103238.GA4212@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
>  with the patch below we will print a big fat warning. (I did not want to
>  deny idle=poll altogether - future HT implementations might work fine
>  with polling idle.)

idle=poll is handy when profiling the kernel with oprofile clock-unhalted
events.  Because if you use the normal halt-based idle loop no profile
"ticks" are accounted to idle time at all and the results are really hard
to understand.
