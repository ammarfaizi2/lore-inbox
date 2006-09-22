Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWIVOcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWIVOcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWIVOcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:32:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19948 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932538AbWIVOcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:32:00 -0400
Date: Fri, 22 Sep 2006 15:31:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Ingo Molnar <mingo@elte.hu>, Martin Bligh <mbligh@google.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060922143102.GA24414@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <compudj@krystal.dyndns.org>,
	Ingo Molnar <mingo@elte.hu>, Martin Bligh <mbligh@google.com>,
	"Frank Ch. Eigler" <fche@redhat.com>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	prasanna@in.ibm.com, Andrew Morton <akpm@osdl.org>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jes Sorensen <jes@sgi.com>, Tom Zanussi <zanussi@us.ibm.com>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	William Cohen <wcohen@redhat.com>, ltt-dev@shafik.org,
	systemtap@sources.redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921214248.GA10097@Krystal>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hate AOL-style me-toos, but there's nothing to add to this mail.
Thanks for this coherent writeup Mathieu.

On Thu, Sep 21, 2006 at 05:42:48PM -0400, Mathieu Desnoyers wrote:
> Hi Ingo,
> 
> I clearly expressed my position in the previous emails, so did you. You argued
> about a use of tracing that is not relevant to my vision of reality, which is :
> 
> - Embedded systems developers won't want a breakpoint-based probe
> - High performance computing users won't want a breakpoint-based probe
> - djprobe is far away from being in an acceptable state on architectures with
>   very inconvenient erratas (x86).
> - kprobe and djprobe cannot access local variables in every cases
> 
> For those reasons, I prefer a jump-over-call approach which lets gcc give us the
> local variables. No need of DWARF or SystemTAP macro Kung Fu. Just C and a
> loadable module.
> 
> By no means is it a replacement for a completely dynamic breakpoint-based
> instrumentation mechanism. I really think that both mechanism should coexist.
> 
> This is my position : I let the distribution/user decide what is appropriate for
> their use. My goal is to provide them a flexible mechanism that takes the
> multiple variety of uses in account without performance impact if they are not
> willing to pay it to benefit from tracing.
> 
> With all due respect, yes, there are Linux users different from the typical
> Redhat client. If your vision is still limited to this scope after a 500
> emails debate, I am afraid that there is very little I can do about it in
> one more.
