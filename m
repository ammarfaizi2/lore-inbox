Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266744AbUGLHAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266744AbUGLHAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 03:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266745AbUGLHAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 03:00:51 -0400
Received: from holomorphy.com ([207.189.100.168]:29580 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266744AbUGLHAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 03:00:43 -0400
Date: Mon, 12 Jul 2004 00:00:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Instrumenting high latency
Message-ID: <20040712070037.GU21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <20040711233750.2050c4b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711233750.2050c4b1.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>> The patch appears to require CONFIG_PREEMPT enabled on uniprocessor and is 
>> i386 only at the moment.

On Sun, Jul 11, 2004 at 11:37:50PM -0700, Andrew Morton wrote:
> Not sure what you mean by "on uniprocessor"?  AFAICT the patch will work
> as-is on uniprocessor and on SMP.  Looks like it'll work with
> CONFIG_PREEMPT=n, too, although that would be a slightly bizarre thing to
> do.
> +				print_symbol("%s\n",
> +					__get_cpu_var(preempt_exit));
> I'll change this to
> 				print_symbol("%s",
> 					__get_cpu_var(preempt_exit));
> 				printk("\n");
> so it doesn't make a mess with CONFIG_KALLSYMS=n.

I'm not 100% sure why UP goes down in flames yet, fscking laptop has no
loggable console. Guess I'd better figure out netconsole or some such.


-- wli
