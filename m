Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271181AbUJVBgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271181AbUJVBgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271052AbUJVBcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:32:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:218 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271158AbUJVB2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:28:46 -0400
Date: Thu, 21 Oct 2004 18:26:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-Id: <20041021182651.082e7f68.akpm@osdl.org>
In-Reply-To: <20041022011057.GC14325@dualathlon.random>
References: <20041021011714.GQ24619@dualathlon.random>
	<417728B0.3070006@yahoo.com.au>
	<20041020213622.77afdd4a.akpm@osdl.org>
	<417837A7.8010908@yahoo.com.au>
	<20041021224533.GB8756@dualathlon.random>
	<41785585.6030809@yahoo.com.au>
	<20041022011057.GC14325@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@novell.com> wrote:
>
> I'm still unsure if the 2.6 lower_zone_protection completely mimics the
>  2.4 lowmem_zone_reserve algorithm if tuned by reversing the pages_min
>  settings accordingly, but I believe it's easier to drop it and replace
>  with a clear understandable API that as well drops the pages_min levels
>  that have no reason to exists anymore

I'd be OK with wapping over to the watermark version, as long as we have
runtime-settable levels.

But I'd be worried about making the default values anything other than zero
because nobody seems to be hitting the problems.

But then again, this get discussed so infrequently that by the time it
comes around again I've forgotten all the previous discussion.  Ho hum.
