Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSGSRm1>; Fri, 19 Jul 2002 13:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSGSRm1>; Fri, 19 Jul 2002 13:42:27 -0400
Received: from fmr03.intel.com ([143.183.121.5]:17345 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S316903AbSGSRm1>; Fri, 19 Jul 2002 13:42:27 -0400
Message-Id: <200207191745.g6JHjBP00767@unix-os.sc.intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH]: scheduler complex macros fixes
Date: Fri, 19 Jul 2002 10:54:18 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
References: <Pine.LNX.4.44.0207191025410.8500-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0207191025410.8500-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 July 2002 01:28 pm, Linus Torvalds wrote:
> On Sat, 20 Jul 2002, Ingo Molnar wrote:
> > well, SCHED_BATCH is in fact ready, so we might as well put it in. All
> > the suggestions mentioned on lkml (or in private) are now included, there
> > are no pending (known) problems, no objections, and a number of people
> > are using it with success.
>
> Well, I do actually have objections, mainly because I think it modifies
> code that I'd rather have cleaned up in other ways _first_ (ie the return
> path to user mode, which has pending irq_count/bh_count/preempt issues
> that I consider to be about a million times more important than batch
> scheduling).
>

Thats too bad.  I've been looking at Ingo's SCHED_BATCH design to help 
suspend processes with out lock problems while doing multithreaded core 
dumps.  

Is there any ETA on the return path to user mode clean up?

--mgross
