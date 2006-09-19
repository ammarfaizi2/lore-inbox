Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWISM7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWISM7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 08:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWISM7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 08:59:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46493 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030237AbWISM67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 08:58:59 -0400
Date: Tue, 19 Sep 2006 13:58:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Nicholas Miell <nmiell@comcast.net>,
       Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: tracing - consensus building insteat of dogfights
Message-ID: <20060919125801.GA12815@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
	Nicholas Miell <nmiell@comcast.net>,
	Paul Mundt <lethal@linux-sh.org>,
	Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
	Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	"Frank Ch. Eigler" <fche@redhat.com>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	William Cohen <wcohen@redhat.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <Pine.LNX.4.64.0609180136340.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609180136340.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been half-way through reading this thread after returning, and I must
say I'm rather annoyed that 80% of it is just Roman vs Ingo and Karim vs
Jes dogfights that run in circles.  Let's try to find some majority optinion
and plans to move forward:

  *) so far everyone but Roman seems to agree we want to support dynamic
     tracing as an integral part of the tracing framework
  *) most people seem to agree that we want some form of in-source annotation
     instead of just external probes

so let's build on this rough consensus and decide on the next steps before
fighting the hard battels.  I think those important steps are:

  1) review and improve the lttng core tracing engine (without static traces
     so far) and get it into mergeable shape.  Make sure it works nicely
     from *probe dynamic tracing handlers.
  2) find a nice syntax for in-source tracing annotations, and implement a
     backend for it using lttng and *probes.

We can fight the hard fight whether we want real static tracing and how
many annotations of what form were after we have those important building
blocks.
