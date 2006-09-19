Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWISQuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWISQuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWISQuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:50:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55196 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030258AbWISQuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:50:05 -0400
To: Martin Bligh <mbligh@google.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu>
	<451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com>
	<4510151B.5070304@google.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 19 Sep 2006 12:49:20 -0400
In-Reply-To: <4510151B.5070304@google.com>
Message-ID: <y0m8xkfer8v.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Bligh <mbligh@google.com> writes:

> [...]  "compiled anew from original sources after deployment" seems
> the most practical to do to me.  From second hand info on using
> systemtap, you seem to need the same compiler and source tree to
> work from anyway [...]

Not quite.  Systemtap does not look at sources, only object code and
its embedded debugging information.  (How many distributions keep
around compilable source trees?)

> [...] It seems like all we'd need to do is "list all references to
> function, freeze kernel, update all references, continue", [...]

One additional problem are external references made *by* the function.
Those too would all have to be relocated to the live data.

Live code patching is theoretically useful for all kinds of things,
but I've never heard it described as relatively simple before! :-)

- FChE
