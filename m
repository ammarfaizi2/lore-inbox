Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUJ1SIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUJ1SIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbUJ1SIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:08:39 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:33497 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263034AbUJ1SHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:07:43 -0400
Date: Thu, 28 Oct 2004 14:04:53 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Swap strangeness: total VIRT ~23mb for all processes
  [...]
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410281407_MC3-1-8D69-9F05@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004 at 14:44:53 +0300 Denis Vlasenko wrote:
> Even if I add up size of every process, *counting libc shared pages
> once per process* (which will overestimate memory usage), I arrive at
> 23mb *total memory required by all processes*. How come kernel
> found 90mb to swap out? There is NOTHING to swap out except those
> 23mb!
>
> (Of course when oom_trigger was running, kernel first swapped out
> those 23mb and then started swapping out momery taken by oom_trigger
> itself, but when oom_trigger was killed, its RAM *and* swapspace
> should be deallocated. Thus I expected to see ~20 mb swap usage).


I am seeing this with Mozilla in an Xnest session.  Even after I terminate
Mozilla + Xnest there is a huge amount of swapped-out memory (~100MB).  This
is on a system with 320MB of memory.  Since the problem goes away when I
leave X I had assumed it was an X bug (Fedora Core 1, not up-to-date) but
now I wonder...  Kernel version is 2.6.9 + patches from L-K but problem is
the same in base 2.6.9.


--Chuck Ebbert  28-Oct-04  10:48:07
