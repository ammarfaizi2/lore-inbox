Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbULFXYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbULFXYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbULFXWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:22:40 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:54964 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261703AbULFXVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:21:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4 panic on AMD64
Date: Tue, 7 Dec 2004 00:22:23 +0100
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       ak@suse.de
References: <1102369238.2826.8.camel@dyn318077bld.beaverton.ibm.com> <20041206141515.7f4bd45f.akpm@osdl.org>
In-Reply-To: <20041206141515.7f4bd45f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200412070022.23645.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 of December 2004 23:15, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Hi Andrew,
> > 
> > I get following panic while booting 2.6.10-rc2-mm4 on my
> > 4-way AMD64 box. Is this known or fixed ?
> 
> Well it is known now, but not fixed, afaik.

Well, I reported exactly the same thing some time ago (on a dual-Opteron). :-)  
It is NUMA-related, or at least SMP-related, apparently, as it does not occur 
on a UP box ...

> > Unable to handle kernel paging request at ffffffffd5a4a4fb RIP:
> > <ffffffff80657607>{numa_add_cpu+7}
> 
> Looks like cpu_to_node(cpu) returned garbage, perhaps.

... so I guess you are right.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
