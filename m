Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262434AbSJaOpi>; Thu, 31 Oct 2002 09:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSJaOpi>; Thu, 31 Oct 2002 09:45:38 -0500
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:7619 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262434AbSJaOph>; Thu, 31 Oct 2002 09:45:37 -0500
Subject: Re: What's left over.
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, n2m1@ltc-eth1000.torolab.ibm.com,
       Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF6C80F3C5.070C630E-ON80256C63.00502DC2@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Thu, 31 Oct 2002 14:46:33 +0000
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 31/10/2002 14:51:31
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> Linux Trace Toolkit (LTT)
>
>I don't know what this buys us.

If you consider developer productivity useful then LTT has definite
benefits especially when combined with kprobes. With the two it is possible
to implant tracepoints without having to code up specific printks: kprobes
can be used to implant a probe, the probe handler can call LTT to record
the event.

Why call LTT instead of having a printk in the probe handler? - for
performance reasons, for latency reasons, because kprobes can implant
probes absolutely anywhere in the system, for analysis reasons - LTT trace
data can be post processed and massaged in a number of ways using the
visualizer tools. Yes you can do some of this using printk directly, but
you can be into a whole heap more work and it will certainly take longer to
implant a temporary tracepoint, recompile, run, remove, recompile the using
the dynamic trace technique of LTT+kprobes.


Richard

