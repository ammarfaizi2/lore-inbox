Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbUKSAFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUKSAFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbUKSAD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:03:58 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:32640 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S263013AbUKSADL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:03:11 -0500
Message-ID: <419D383D.4000901@ribosome.natur.cuni.cz>
Date: Fri, 19 Nov 2004 01:03:09 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041114
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet>	<4193E056.6070100@tebibyte.org>	<4194EA45.90800@tebibyte.org>	<20041113233740.GA4121@x30.random>	<20041114094417.GC29267@logos.cnet>	<20041114170339.GB13733@dualathlon.random>	<20041114202155.GB2764@logos.cnet>	<419A2B3A.80702@tebibyte.org>	<419B14F9.7080204@tebibyte.org>	<20041117012346.5bfdf7bc.akpm@osdl.org>	<419CD8C1.4030506@ribosome.natur.cuni.cz> <20041118131655.6782108e.akpm@osdl.org> <419D25B5.1060504@ribosome.natur.cuni.cz> <419D2987.8010305@cyberone.com.au>
In-Reply-To: <419D2987.8010305@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I just tested 2.6.7 and it works comparably to 2.4.28.
swpd value reported by vmstat is actually 1172736,
actually inspecting the previous results from 2.4.28
show also this number. But "swapon -s" reports 1172732.
I'm puzzled. vmstat comes from gentoo procps-3.2.3-r1.


  Anyway, plain 2.6.7 kills only the application asking for
so much memory and logs via syslog:
Out of Memory: Killed process 58888 (RNAsubopt)

  It's a lot better compared to what we have in 2.6.10-rc2,
from my user's view.

  I cannot easily reverse the tbtc patch from 2.6.10-rc2 tree,
but applying the tbtc patch over 2.6.7 gives me same behaviour
as on plain 2.6.7 - so only the RNAsubopt application get's
killed.

  The problem must have been introduced between 2.6.7
and 2.6.10-rc2 but is not directly related to tbtc patch in it's
original form:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109122597407401&w=2

Hope this helps.
Martin
  
