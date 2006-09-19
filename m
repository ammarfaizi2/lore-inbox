Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751948AbWISMIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbWISMIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 08:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbWISMIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 08:08:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5263 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751948AbWISMIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 08:08:55 -0400
Date: Tue, 19 Sep 2006 13:08:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060919120825.GC4965@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Bligh <mbligh@mbligh.org>, Ingo Molnar <mingo@elte.hu>,
	Roman Zippel <zippel@linux-m68k.org>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
	Michel Dagenais <michel.dagenais@polymtl.ca>, fche@redhat.com
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org> <20060914203430.GB9252@elte.hu> <4509C1D0.6080208@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509C1D0.6080208@mbligh.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 01:55:44PM -0700, Martin Bligh wrote:
> 1. They're harder to maintain out of tree.
> 2. they're written in some jibberish awk crap
> 3. They're slower. If you're doing thousands of tracepoints a second,
> 	into a circular 8GB log buffer, that *does* matter. You want
> 	to peturb what you're measuring as little as possible.

agreed to all these and I'd like to add:

 4.  If you merge proper dynamic tracing infrastructure you get static
     traces for free.  It's just a bunch of macros directly calling
     the trace function also used by the dynamic tracing code, maybe
     keyed of an enable variable.

