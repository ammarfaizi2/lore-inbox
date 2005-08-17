Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVHQTSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVHQTSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVHQTSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:18:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16581 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751202AbVHQTSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:18:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Chris Wright <chrisw@osdl.org>
X-Fcc: ~/Mail/linus
Cc: "Bhavesh P. Davda" <bhavesh@avaya.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, "Glass, Kathleen K (Kathy)" <kkglass@avaya.com>,
       "Rhodes, James E (James)" <jrhodes@avaya.com>
Subject: Re: [PATCH 2.6.12.5] NPTL signal delivery deadlock fix
In-Reply-To: Chris Wright's message of  Wednesday, 17 August 2005 12:00:20 -0700 <20050817190020.GO7991@shell0.pdx.osdl.net>
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20050817191836.0945E180988@magilla.sf.frob.com>
Date: Wed, 17 Aug 2005 12:18:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Bhavesh P. Davda (bhavesh@avaya.com) wrote:
> > This bug is quite subtle and only happens in a very interesting
> > situation where a real-time threaded process is in the middle of a
> > coredump when someone whacks it with a SIGKILL. However, this deadlock
> > leaves the system pretty hosed and you have to reboot to recover.
> > 
> > Not good for real-time priority-preemption applications like our
> > telephony application, with 90+ real-time (SCHED_FIFO and SCHED_RR)
> > processes, many of them multi-threaded, interacting with each other for
> > high volume call processing.
> 
> Nice catch, also looks like something for -stable series.  Roland, any
> issue with this patch?

Ouch!  That one must be my fault.  I did a quick scan and didn't find any
other typos of that nature.  This fix definitely should go in everywhere ASAP.


Thanks,
Roland
