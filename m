Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTEATzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 15:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbTEATzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 15:55:25 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:2995 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262262AbTEATzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 15:55:22 -0400
Date: Thu, 1 May 2003 13:07:38 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Michael Hunold <hunold-ml@web.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 5 potential user-pointer errors that allow arbitrary
 reads from kernel
In-Reply-To: <3EB118F9.9030003@web.de>
Message-ID: <Pine.GSO.4.44.0305011305580.28595-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot for the feedback and the incoming patch!

-Junfeng

On Thu, 1 May 2003, Michael Hunold wrote:

> Hello Junfeng,
>
> > This is a resend (the previous report was ignored, however I feel that
> > these bugs could be severe).
>
> > Please confirm or clarify. Thanks!
>
> > [BUG] proc_dir_entry.write_proc can take tainted inputs.
> > av7110_ir_write_proc is assigned to proc_dir_entry.write_proc
> >
> > /home/junfeng/linux-2.5.63/drivers/media/dvb/av7110/av7110_ir.c:116:av7110_ir_write_proc:
> > ERROR:TAINTED:116:116: passing tainted ptr 'buffer' to __constant_memcpy
> > [Callstack:
> > /home/junfeng/linux-2.5.63/net/core/pktgen.c:991:av7110_ir_write_proc((tainted
> > 1))]
>
> Confirmed. I'll post a patch when I'm back at work again on Monday.
>
> CU
> Michael.
>

