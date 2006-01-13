Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWAMPyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWAMPyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWAMPyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:54:52 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:17088 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964983AbWAMPyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:54:51 -0500
Subject: Re: 2.6.15-rt4 failure with LATENCY_TRACE on x86_64
From: Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <williams@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1137164761.3332.2.camel@localhost.localdomain>
References: <1137103652.11354.40.camel@localhost.localdomain>
	 <1137122280.7338.6.camel@localhost.localdomain>
	 <1137164761.3332.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 10:54:39 -0500
Message-Id: <1137167679.7241.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 09:06 -0600, Clark Williams wrote:
> On Thu, 2006-01-12 at 22:18 -0500, Steven Rostedt wrote:
> > OK, I'm actually sending you this email on a x86_64 running
> > 2.6.15-rt4-sr2, with latency tracing on.  But unfortunately, I have a
> > AMD X2 that each core has it's own tsc counter that is not in sync, and
> > since the latency tracer uses tsc, I get garbage.  But beware, the tsc
> > does slow down when the cpu idles, so it gives bad results even for non
> > x2 systems.
> > 
> Hmm, I didn't realize that (I'm running on a uni-processor system). I
> just pulled your rt4-sr2 patch and will apply/rebuild/test. 
> 
> > I finally was able to boot this with using the PM timer, but the
> > beginning of my dmesg is still filled with:
> > 
> > read_tsc: ACK! TSC went backward! Unsynced TSCs?
> > 
> > Have you tried booting with idle=poll? I wonder if that would help?
> 
> No, I thought that was strictly an SMP issue. I'll try it as well.

It effects SMP mostly.  I doubt that it will effect UP, but the tsc is
still not consistent.

-- Steve


