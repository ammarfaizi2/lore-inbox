Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUGMCsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUGMCsx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 22:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUGMCsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 22:48:53 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:16284 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262406AbUGMCsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 22:48:50 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: Preempt Threshold Measurements
Date: Mon, 12 Jul 2004 22:48:50 -0400
User-Agent: KMail/1.6.2
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <200407121943.25196.devenyga@mcmaster.ca> <20040713024051.GQ21066@holomorphy.com>
In-Reply-To: <20040713024051.GQ21066@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407122248.50377.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I'm not particularly educated in kernel internals yet, here's some 
reports from the system when its running.

6ms non-preemptible critical section violated 4 ms preempt threshold starting 
at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
 [<c014007b>] do_munmap+0xeb/0x140
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c014007b>] do_munmap+0xeb/0x140
 [<c014010f>] sys_munmap+0x3f/0x60
 [<c0103ee1>] sysenter_past_esp+0x52/0x71
6ms non-preemptible critical section violated 4 ms preempt threshold starting 
at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
 [<c014007b>] do_munmap+0xeb/0x140
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c014007b>] do_munmap+0xeb/0x140
 [<c014010f>] sys_munmap+0x3f/0x60
 [<c0103ee1>] sysenter_past_esp+0x52/0x71
6ms non-preemptible critical section violated 4 ms preempt threshold starting 
at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
 [<c014007b>] do_munmap+0xeb/0x140
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c014007b>] do_munmap+0xeb/0x140
 [<c014010f>] sys_munmap+0x3f/0x60
 [<c0103ee1>] sysenter_past_esp+0x52/0x71
5ms non-preemptible critical section violated 4 ms preempt threshold starting 
at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
 [<c014007b>] do_munmap+0xeb/0x140
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c014007b>] do_munmap+0xeb/0x140
 [<c014010f>] sys_munmap+0x3f/0x60
 [<c0103ee1>] sysenter_past_esp+0x52/0x71


-- 
Gabriel Devenyi
devenyga@mcmaster.ca


On Monday 12 July 2004 22:40, William Lee Irwin III wrote:
> On Mon, Jul 12, 2004 at 07:43:25PM -0400, Gabriel Devenyi wrote:
> > Keeping in mind that I'm using the nvidia-kernel drivers, here are my
> > preempt threshold violations.
> > 6ms non-preemptible critical section violated 4 ms preempt threshold
> > starting at kernel_fpu_begin+0xd/0x50 and ending at
> > _mmx_memcpy+0x127/0x170 [<c0241987>] _mmx_memcpy+0x127/0x170
> >  [<c01163b0>] dec_preempt_count+0x110/0x120
> >  [<c0241987>] _mmx_memcpy+0x127/0x170
> >  [<c012d3b5>] load_module+0x835/0x900
> >  [<c013c84e>] unmap_vmas+0x10e/0x1f0
> >  [<c012d4fb>] sys_init_module+0x7b/0x230
> >  [<c0103ee1>] sysenter_past_esp+0x52/0x71
>
> Things tend to be slow and stupid in the interest of robustness during
> system initialization.
>
> I'd suggest ignoring those unless you're specifically interested in boot
> time (in which case you should be doing things for yourself) and focusing
> on ones reported during normal usage after the system is up.
>
>
> -- wli
> _______________________________________________
> ck@vds.kolivas.org
> ck mailing list - unmoderated. Please reply-to-all when posting.
> http://bhhdoa.org.au/mailman/listinfo/ck
