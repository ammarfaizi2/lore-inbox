Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269779AbUICTuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269779AbUICTuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbUICTsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:48:32 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:63390 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269795AbUICTi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:38:27 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Christoph Lameter <clameter@sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       tim@physik3.uni-rostock.de, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <413820A2.80409@mvista.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com>
	 <1094164096.14662.345.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021536450.28532@schroedinger.engr.sgi.com>
	 <1094166858.14662.367.camel@cog.beaverton.ibm.com>
	 <B6E8046E1E28D34EB815A11AC8CA312902CF6059@mtv-atc-605e--n.corp.sgi.com>
	 <1094170054.14662.391.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021737310.6412@schroedinger.engr.sgi.com>
	 <1094175004.14662.440.camel@cog.beaverton.ibm.com>
	 <413820A2.80409@mvista.com>
Content-Type: text/plain
Message-Id: <1094239970.14662.516.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Sep 2004 12:32:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 00:43, George Anzinger wrote:
> john stultz wrote:
> > On Thu, 2004-09-02 at 17:47, Christoph Lameter wrote:
> > 
> >>On Thu, 2 Sep 2004, john stultz wrote:
> > read(): Rather then just giving the address of the register, the read
> > call allows for timesource specific logic. This lets us use jiffies as a
> > timesource, or in cases like the ACPI PM timesource, where the register
> > must be read 3 times in order to ensure a correct value is latched, we
> > can avoid having to include that logic into the generic code, so it does
> > not affect systems that do not use or have that timesource.
> 
> I am not convince that 3 reads are in fact needed.  In fact, I am amost certain 
> that two is more than enough.  In fact, it takes so long to read it that I just 
> use one read and a sanity check in the HRT code.  Here is the code I use:

[snip]

I'd have to defer to Dominik (acpi-pm author) for that. But the case
remains, to get a "good" value, you have to do more then just give
access to the raw register.

thanks
-john

