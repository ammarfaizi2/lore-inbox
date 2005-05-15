Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVEOJhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVEOJhG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVEOJhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:37:06 -0400
Received: from colin.muc.de ([193.149.48.1]:22792 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261589AbVEOJhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:37:02 -0400
Date: 15 May 2005 11:37:01 +0200
Date: Sun, 15 May 2005 11:37:01 +0200
From: Andi Kleen <ak@muc.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515093701.GA68736@muc.de>
References: <20050513232708.GC13846@redhat.com> <1116027488.6380.55.camel@mindpipe> <1116084186.20545.47.camel@localhost.localdomain> <1116088229.8880.7.camel@mindpipe> <1116089068.6007.13.camel@laptopd505.fenrus.org> <1116093396.9141.11.camel@mindpipe> <1116093694.6007.15.camel@laptopd505.fenrus.org> <1116098504.9141.31.camel@mindpipe> <1116100126.6007.17.camel@laptopd505.fenrus.org> <1116114052.9141.38.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116114052.9141.38.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was under the impression that P4 and later processors do not vary the
> TSC rate when doing frequency scaling.  This is mentioned in the
> documentation for the high res timers patch.

Prescott and later do not vary TSC, but P4s before that do.
On x86-64 it is true because only Nocona is supported which has a 
pstate invariant TSC.

The latest x86-64 kernel has a special X86_CONSTANT_TSC internal
CPUID bit, which is set in that case. If some other subsystem
uses it I would recommend to port that to i386 too.

-Andi
