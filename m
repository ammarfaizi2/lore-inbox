Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbVH2FZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVH2FZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 01:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVH2FZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 01:25:08 -0400
Received: from gromit.tds.de ([193.28.97.130]:28059 "EHLO gromit.tds.de")
	by vger.kernel.org with ESMTP id S1750897AbVH2FZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 01:25:06 -0400
Date: Mon, 29 Aug 2005 07:24:55 +0200
From: Tim Weippert <weiti@security.tds.de>
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk,
       davej@codemonkey.org.uk, akpm@osdl.org, discuss@x86-64.org
Subject: Re: Bad page state on AMD Opteron Dual System with kernel 2.6.13-rc6-git13
Message-ID: <20050829052454.GA8172@pbkg4>
Reply-To: Tim Weippert <weiti@security.tds.de>
References: <20050826165342.GA11796@pbkg4> <43110363.7020808@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43110363.7020808@gentoo.org>
Organization: TDS Informationstechnologie AG
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2005 at 01:20:51AM +0100, Daniel Drake wrote:
> Hi,
> 
> Tim Weippert wrote:
> >i have read some postings concerning the following Kernel Messages:
> >
> >Aug 26 18:04:01 montdsnsu3 kernel: grep[11619] general protection
> >rip:2aaaaaaaed43 rsp:7fffff9c0740 error:0
> >Aug 26 18:08:02 montdsnsu3 kernel: ping[14867] general protection
> >rip:2aaaaaaaed43 rsp:7fffffdbf300 error:0
> >Aug 26 18:08:03 montdsnsu3 kernel: grep[14987] general protection
> >rip:2aaaaaaaed43 rsp:7fffffdbfce0 error:0
> >Aug 26 18:08:03 montdsnsu3 kernel: grep[15041] general protection
> >rip:2aaaaaaaed43 rsp:7fffff9bf550 error:0
> >
> >And the Bad Page State Messages:
> >
> >Bad page state at prep_new_page (in process 'sh', page ffff8100011a69c8)
> >flags:0x0100000000000014 mapping:0000000000000000 mapcount:-3 count:0
> >Backtrace:
> >
> >Call Trace:<ffffffff8015a653>{bad_page+99}
> ><ffffffff8015aa31>{prep_new_page+65}
> >       <ffffffff8015b1e2>{buffered_rmqueue+306}
> ><ffffffff8015b425>{__alloc_pages+261}
> >       <ffffffff8015b7c5>{get_zeroed_page+37}
> ><ffffffff801691b7>{__pmd_alloc+55}
> >       <ffffffff8016614e>{copy_page_range+462}
> ><ffffffff80131da4>{copy_mm+820}
> >       <ffffffff80132cba>{copy_process+2282}
> ><ffffffff80133407>{do_fork+215}
> >       <ffffffff8010db7a>{system_call+126}
> ><ffffffff8010deeb>{ptregscall_common+103}
> >       
> >Trying to fix it up, but a reboot is needed
> 
> Seems to be an identical problem as was filed here:
> 
> 	http://bugs.gentoo.org/show_bug.cgi?id=103497
> 
> This bug report seems to suggest that the ondemand scaling governor may be 
> at fault. Does your setup use this too?
> 
> (CC'ing some extra people to make sure problem is known)
> 

As this is an Server, i don't even use cpufreq on this machine. So it
think this isn't the same problem ...

Kind regards, 

    weiti

p.s: Please CC me, cause i am not subscribed on lkml.

-- 

Interpunktion und Orthographie dieser Email ist frei erfunden.
Eine Übereinstimmung mit aktuellen oder ehemaligen Regeln
wäre rein zufällig und ist nicht beabsichtigt.

Tim Weippert <weiti@topf-sicret.org>
http://www.topf-sicret.org/
