Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270136AbTGPMGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270487AbTGPMGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:06:31 -0400
Received: from main.gmane.org ([80.91.224.249]:51399 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270136AbTGPMGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:06:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: ALSA timer and 2.6.0-test1 panic
Date: Wed, 16 Jul 2003 14:16:32 +0200
Message-ID: <yw1x3ch6650f.fsf@users.sourceforge.net>
References: <yw1xlluyln01.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:OB6vjb66eqP9rpOOn0nJG8UOtIg=
Cc: alsa-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> I get thousands of these messages when using the ALSA timer in kernel
> 2.6.0-test1:
>
> bad: scheduling while atomic!
> Call Trace:
>  [<c0118408>] schedule+0x3ab/0x3b0
>  [<c0123190>] schedule_timeout+0x5f/0xb3
>  [<d08fffb6>] snd_timer_user_poll+0x2a/0x41 [snd_timer]
>  [<c0123128>] process_timeout+0x0/0x9
>  [<c0160aa7>] do_poll+0xa1/0xc0
>  [<c0160c62>] sys_poll+0x19c/0x28e
>  [<c0160035>] __pollwait+0x0/0xc6
>  [<c010911b>] syscall_call+0x7/0xb
>
> bad: scheduling while atomic!
> Call Trace:
>  [<c0118408>] schedule+0x3ab/0x3b0
>  [<c014ed0e>] sys_read+0x61/0x63
>  [<c0109142>] work_resched+0x5/0x16
>
> bad: scheduling while atomic!
> Call Trace:
>  [<c0118408>] schedule+0x3ab/0x3b0
>  [<c014ed0e>] sys_read+0x61/0x63
>  [<c0109142>] work_resched+0x5/0x16
>
> Everything works like it should anyhow, until the program stops.  At
> that time the kernel panics (killing interrupt handler).

If I disable the preemptive kernel it works fine.

-- 
Måns Rullgård
mru@users.sf.net

