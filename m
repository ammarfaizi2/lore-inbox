Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUE2Cdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUE2Cdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 22:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUE2Cdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 22:33:42 -0400
Received: from potato.cts.ucla.edu ([149.142.36.49]:5051 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S262794AbUE2Cdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 22:33:40 -0400
Date: Fri, 28 May 2004 19:32:51 -0700 (PDT)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: oops, 2.4.26 and jfs
In-Reply-To: <Pine.LNX.4.58.0405281757360.18184@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.58.0405281915560.18184@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0405281307550.18184@potato.cts.ucla.edu>
 <1085776292.13846.18.camel@shaggy.austin.ibm.com>
 <Pine.LNX.4.58.0405281757360.18184@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2004, Chris Stromsoe wrote:

> Aside from that:
>
> > May 26 06:28:10 begonia kernel: __alloc_pages: 0-order allocation
> > failed (gfp=0x1f0/0)
>
> I'm curious about why 0-order allocations would fail.  From everything
> I've read (google searching for the error message), that indicates an
> out of memory condition, which shouldn't be the case.
>
> The box in question has 4Gb of physical ram (512Mb is used as tmpfs) and
> 9Gb of swap.  When the oops happened, no swap was in use.  Physical ram
> was pretty much filled, but no swap at all.  OOM_KILLER is not enabled.
>
> There's nothing especially exotic in the box.  It does a lot of network
> traffic (eepro100) and a lot of disk traffic (aic7xxx).  The morning
> cron jobs had just kicked off.  Two of them do "find /"  -- I believe
> that the second one was running when it happened.


Looking back through my mail logs, I've had (and reported) problems with
0-order allocations failing and random hangs with this same workload on 2
other machines at least as far back as early April 3, 2004, with 2.4.23.
See <http://marc.theaimsgroup.com/?l=linux-kernel&m=107835211117799&w=2>
for an earlier report.

Differences between then and now:  I'm using tmpfs instead of rd,
CONFIG_HIGHIO=y is set, and I've upgraded the kernel to 2.4.26.


-Chris
