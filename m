Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWIRP0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWIRP0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWIRP0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:26:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16336 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751560AbWIRP0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:26:17 -0400
Subject: Re: tracepoint maintainance models
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
In-Reply-To: <20060918150231.GA8197@elte.hu>
References: <450D182B.9060300@opersys.com>
	 <20060917112128.GA3170@localhost.usen.ad.jp>
	 <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal>
	 <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com>
	 <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com>
	 <20060918150231.GA8197@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 16:48:10 +0100
Message-Id: <1158594491.6069.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-18 am 17:02 +0200, ysgrifennodd Ingo Molnar:
> also, there should be only a single switch for markups: either all of 
> them are compiled in or none of them. That simplifies the support 
> picture and gets rid of some ugly #ifdefs. Distro kernels will likely 
> enable all of thems, so there will be nice uniformity all across.

I think your implementation is questionable if it causes any kind of
jumps and conditions, even marked unlikely. Just put the needed data in
a seperate section which can be used by the debugging tools. No need to
actually mess with the code for the usual cases.

Alan

