Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUJ2Tnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUJ2Tnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbUJ2TlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:41:02 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:54284 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261676AbUJ2TOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:14:44 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Swap strangeness: total VIRT ~23mb for all processes  [...]
Date: Fri, 29 Oct 2004 22:13:57 +0300
User-Agent: KMail/1.5.4
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200410281407_MC3-1-8D69-9F05@compuserve.com>
In-Reply-To: <200410281407_MC3-1-8D69-9F05@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410292213.57156.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 21:04, Chuck Ebbert wrote:
> On Thu, 28 Oct 2004 at 14:44:53 +0300 Denis Vlasenko wrote:
> > Even if I add up size of every process, *counting libc shared pages
> > once per process* (which will overestimate memory usage), I arrive at
> > 23mb *total memory required by all processes*. How come kernel
> > found 90mb to swap out? There is NOTHING to swap out except those
> > 23mb!
> >
> > (Of course when oom_trigger was running, kernel first swapped out
> > those 23mb and then started swapping out momery taken by oom_trigger
> > itself, but when oom_trigger was killed, its RAM *and* swapspace
> > should be deallocated. Thus I expected to see ~20 mb swap usage).
> 
> 
> I am seeing this with Mozilla in an Xnest session.  Even after I terminate
> Mozilla + Xnest there is a huge amount of swapped-out memory (~100MB).  This
> is on a system with 320MB of memory.  Since the problem goes away when I
> leave X I had assumed it was an X bug (Fedora Core 1, not up-to-date) but
> now I wonder...  Kernel version is 2.6.9 + patches from L-K but problem is
> the same in base 2.6.9.

I have no additional data yet, but it looks similar to the "oom triggers too
early while there's plenty of cache to get rid of" misbehavior which
was frequently seen in 2.4.10 era.

However, "90mb in swap on a system with 30 mb total virtual space of all
processes combined" is something entirely new :)
--
vda

