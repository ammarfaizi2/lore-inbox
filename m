Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVKVCcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVKVCcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVKVCcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:32:10 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:54765 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964873AbVKVCcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:32:09 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Dave Jones <davej@redhat.com>
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Date: Tue, 22 Nov 2005 13:31:44 +1100
User-Agent: KMail/1.8.2
Cc: Ken Moffat <zarniwhoop@ntlworld.com>,
       Alexander Clouter <alex@digriz.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, blaisorblade@yahoo.it, davej@codemonkey.org.uk
References: <20051121181722.GA2599@inskipp.digriz.org.uk> <Pine.LNX.4.63.0511220102330.18504@deepthought.mydomain> <20051122022215.GB1288@redhat.com>
In-Reply-To: <20051122022215.GB1288@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511221331.45601.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005 01:22 pm, Dave Jones wrote:
> On Tue, Nov 22, 2005 at 01:21:18AM +0000, Ken Moffat wrote:
>  > On Mon, 21 Nov 2005, Alexander Clouter wrote:
>  > >The use of the 'ignore_nice' sysfs file is confusing to anyone using
>  > > it. This
>  > >removes the sysfs file 'ignore_nice' and in its place creates a
>  > >'ignore_nice_load' entry which defaults to '1'; meaning nice'd
>  > > processes are
>  > >not counted towards the 'business' calculation.
>  > >
>  > >WARNING: this obvious breaks any userland tools that expected
>  > > ignore_nice' to
>  > >exist, to draw attention to this fact it was concluded on the mailing
>  > > list that the entry should be removed altogether so the userland app
>  > > breaks and so
>  > >the author can build simple to detect workaround.  Having said that it
>  > >seems
>  > >currently very few tools even make use of this functionality; all I
>  > > could find was a Gentoo Wiki entry.
>  > >
>  > >Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>
>  >
>  >  Great.  I get to rewrite my initscript for the ondemand governor to
>  > test for yet another kernel version, and write a 0 to yet another sysfs
>  > file, just so that any compile I start in an xterm on my desktop box can
>  > make the processor work for its living.
>  >
>  >  Just what have you cpufreq guys got against nice'd processes ?  It's
>  > enough to drive a man to powernowd ;)
>
> The opinion on this one started out with everyone saying "Yeah,
> this is dumb, and should have changed". Now that the change appears
> in a mergable patch, the opinion seems to have swung the other way.
>
> I'm seriously rethinking this change, as no matter what we do,
> we're going to make some people unhappy, so changing the status quo
> seems ultimately pointless.

Eh? I thought he was agreeing with niced processes running full speed but that 
he misunderstood that that was the new default. Oh well I should have just 
shut up.

Con
