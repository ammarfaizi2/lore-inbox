Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266172AbUFIPfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266172AbUFIPfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUFIPc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:32:27 -0400
Received: from fmr06.intel.com ([134.134.136.7]:61835 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266167AbUFIPbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:31:48 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: Pavel Machek <pavel@ucw.cz>, Mark Gross <mgross@linux.jf.intel.com>
Subject: Re: swsusp "not enough swap space" 2.6.5-mm6.
Date: Wed, 9 Jun 2004 08:32:04 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200406080829.35120.mgross@linux.intel.com> <20040608230450.GA13916@elf.ucw.cz>
In-Reply-To: <20040608230450.GA13916@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406090832.04064.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 June 2004 16:04, Pavel Machek wrote:
> Hi!
>
> > I'm sorry for not having more information, but the failing computer is my
> > home laptop (I'll get more details after work or I'll bring it in
> > tomorrow for more details).
> >
> > Anyway, this thing does software suspend using the 2.6.2-mm1 kernel, and
> > last night I was updating it to 2.6.5-mm6, and I started getting these
> > not enough disk space errors.
> >
> > I found your bug fix patch,
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=107806008626357&w=2
> >  and checked that it is included in the 2.6.5-mm6 kernel I'm using.
> >
> > Without more information does this problem ring any bells?
> >
> > Can you recommend a "good" kernel version that does reliable swsusp?
>
> Get 2.6.6, and set swappiness to 100.
>
> 								Pavel

2.6.6 still fails, just like the failure reported by the thread independent of 
swappiness: 

http://marc.theaimsgroup.com/?t=107806010900002&r=1&w=2

However; as hinted in the thread turning off premption does seem to fix the 
problem.

When will the CONFIG_PREEMPT work with swsusp again?  (it works with 2.6.2-mm1 
on my system a NEC VERSA E120 Daylite with 512MB ram)  

Also, why does it burp out such a bogus message?  not enough swap, when its 
trying to dump only 7000 some pages to a 700MB swap partiion that isn't used 
yet is missleading.


--mgross



