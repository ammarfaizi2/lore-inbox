Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWITLUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWITLUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 07:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWITLUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 07:20:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:35500 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751124AbWITLUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 07:20:04 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, mbligh@google.com
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu>
	<451008AC.6030006@google.com> <20060919153107.GA16414@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 20 Sep 2006 13:19:29 +0200
In-Reply-To: <20060919153107.GA16414@elte.hu>
Message-ID: <p73ac4ukcou.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
> 
> yeah, this would be nice - if it werent it for function pointers, and if 
> all kernel functions were relocatable. But if you can think of a method 
> to do this, it would be nice.

x86-64 did it for some time statically to replace mem copies and some other
functions. Basically it just patches the beginning of the other function
to a jump. However this assumes that the code doesn't contain absolute addresses
(e.g. no switches). In the x86-64 it's easy because only assembly functions
are threated this way. 

-Andi
