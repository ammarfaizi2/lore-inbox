Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758480AbWLADep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758480AbWLADep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 22:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758496AbWLADep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 22:34:45 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:25296 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1758476AbWLADeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 22:34:44 -0500
Date: Fri, 1 Dec 2006 12:34:23 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 1/2] atomic.h atomic64_t standardization
Message-ID: <20061201033423.GB27639@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Mathieu Desnoyers <compudj@krystal.dyndns.org>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>, Jes Sorensen <jes@sgi.com>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
	systemtap@sources.redhat.com
References: <20061124215518.GE25048@Krystal> <20061127165643.GD5348@infradead.org> <20061201031153.GA10835@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201031153.GA10835@Krystal>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 10:11:53PM -0500, Mathieu Desnoyers wrote:
> --- a/include/asm-generic/atomic.h
> +++ b/include/asm-generic/atomic.h
[snip]
> +#if 0
> +/* Atomic add unless is only effective on atomic_t on powerpc (at least) */
> +static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
> +{
> +	atomic_t *v = (atomic_t *)l;
> +	
> +	return atomic_add_unless(v, a, u);
> +}
> +
> +static inline long atomic_long_inc_not_zero(atomic_long_t *l)
> +{
> +	atomic_t *v = (atomic_t *)l;
> +	
> +	return atomic_inc_not_zero(v);
> +}
> +#endif //0
> +

Why is this in the patch?
