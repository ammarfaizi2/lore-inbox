Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWISATa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWISATa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 20:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWISATa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 20:19:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29100 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030325AbWISAT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 20:19:29 -0400
Subject: Re: [PATCH] Linux Kernel Markers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Ingo Molnar <mingo@elte.hu>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
In-Reply-To: <20060918234502.GA197@Krystal>
References: <20060918234502.GA197@Krystal>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Sep 2006 01:41:29 +0100
Message-Id: <1158626490.6069.214.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-18 am 19:45 -0400, ysgrifennodd Mathieu Desnoyers:
> +#define MARK_KPROBE(event, format, args...)	MARK_SYM(event);
> +
> +#define MARK_JPROBE(event, format, args...) \
> +	do { \
> +		MARK_SYM(event); \
> +		JPROBE_TARGET; \
> +	} while(0)

Seems a good path and has scope to be combined with some of our debug
trace printks to take them out into trace tool space instead of
cluttering up mainstream

