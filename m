Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWISMFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWISMFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 08:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWISMFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 08:05:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4586 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751239AbWISMFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 08:05:48 -0400
Date: Tue, 19 Sep 2006 13:05:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Tim Bird <tim.bird@am.sony.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060919120517.GB4965@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
	Tim Bird <tim.bird@am.sony.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
	Michel Dagenais <michel.dagenais@polymtl.ca>
References: <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com> <20060914200040.GB5812@elte.hu> <4509BF9D.5080806@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509BF9D.5080806@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 04:46:21PM -0400, Karim Yaghmour wrote:
> Ideally, though, markers should be self-contained. IOW, the person
> implementing such a marker should not need to edit any other file
> that the one being worked on to add an instrumentation point --
> at least that's the way I think is easiest. What this means is that
> you would be able to add an instrumentation point in the kernel,
> build it, run the tracing and view the trace with your new event
> without any further intervention on any tool, header, or anything
> else.

Just in case my first mail on this subject wasn't clear enough I
completely agree with that statement.  complex traces detaches from
the actual sourcecode are an uteer maintaince nightmare and should
be avoided for anything but spontanous debugging.  For that case they
are of course imensely useful.   Thus we need two forms to specify
probes, and to not make the tracing an utter mess they need to share
as much infrastructure as possible.

