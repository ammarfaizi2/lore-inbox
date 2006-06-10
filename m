Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWFJQYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWFJQYR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWFJQYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:24:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63903 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751193AbWFJQYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:24:16 -0400
Date: Sat, 10 Jun 2006 09:24:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.16-rc6-mm2
Message-Id: <20060610092412.66dd109f.akpm@osdl.org>
In-Reply-To: <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	<6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006 12:23:37 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> On 10/06/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/
> >
> 
> I get a lot of "BUG: using smp_processor_id() in preemptible"
> 
> Real Time Clock Driver v1.12ac
> printk: 22314 messages suppressed.
> BUG: using smp_processor_id() in preemptible [00000001] code: restorecon/393
> caller is __handle_mm_fault+0x2b/0x20d
>  [<c0103ba8>] show_trace+0xd/0xf
>  [<c0103c7a>] dump_stack+0x17/0x19
>  [<c0203bcc>] debug_smp_processor_id+0x8c/0xa0
>  [<c0160e60>] __handle_mm_fault+0x2b/0x20d
>  [<c0116f7b>] do_page_fault+0x226/0x61f
>  [<c0103959>] error_code+0x39/0x40

You'll need to disable CONFIG_DEBUG_PREEMPT, sorry.

Christoph, that is the last straw - I'll drop all these patches.  There's a
file in -mm Documentation/SubmitChecklist - please tape to to yor monitor.

page-flags.h was an inappropriate place for that code.
