Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTLJKSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 05:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTLJKSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 05:18:25 -0500
Received: from dsl-213-023-219-087.arcor-ip.net ([213.23.219.87]:4230 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S263024AbTLJKSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 05:18:23 -0500
Message-ID: <3FD6F2EB.5090300@kubla.de>
Date: Wed, 10 Dec 2003 11:18:19 +0100
From: Dominik Kubla <dominik@kubla.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en, de
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Stephen Satchell <list@satchell.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Swap performance statistics in 2.6 -- which /proc file has it?
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>  <1070911748.2408.39.camel@dhcppc4>  <3FD546D5.2000003@nishanet.com>  <1070975964.5966.5.camel@ssatchell1.pyramid.net>  <Pine.LNX.4.53.0312090854080.8425@chaos> <1070981185.6243.58.camel@ssatchell1.pyramid.net> <Pine.LNX.4.53.0312091014250.525@chaos> <3FD62845.8090301@kubla.de> <Pine.LNX.4.53.0312091520120.3865@chaos>
In-Reply-To: <Pine.LNX.4.53.0312091520120.3865@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> Hmm. I was talking about real stuff, not some theory.....

[...]

> Sun Microsystems Inc.	SunOS 5.5.1	Generic	May 1996
> # vmstat -a
> Usage: vmstat [-cisS] [disk ...] [interval [count]]
> # sar -B
> sar: illegal option -- B
> usage: sar [-ubdycwaqvmpgrkA][-o file] t [n]
> 	sar [-ubdycwaqvmpgrkA][-s hh:mm][-e hh:mm][-i ss][-f file]
> # sar -r
> sar: can't open /var/adm/sa/sa09
> No such file or directory
> # uname -a
> SunOS hal 5.5.1 Generic sun4m sparc SUNW,SPARCstation-5

[...]

> ... Guess not.

If you try this on a Linux system with the sysstat package installed you 
might be surprised... (That's why i said the Linux part in the mentioned 
book is outdated: it does not tell you that sar is available and recommends 
to parse the proc files)

# dpkg -l sysstat
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  sysstat        5.0.0-1        sar, iostat and mpstat - system performance

# vmstat -a
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free  inact active   si   so    bi    bo   in    cs us sy id wa
  0  0      0 113072 219600 173056    0    0   320    80 1055   203  6  2 78 14

# sar -B 60
Linux 2.6.0-test5-bk4 (duron)   12/10/03

11:13:24     pgpgin/s pgpgout/s   fault/s  majflt/s
11:14:24         0.00      3.80     13.38      0.00
Average:         0.00      3.80     13.38      0.00

# sar -r 60
Linux 2.6.0-test5-bk4 (duron)   12/10/03

11:14:53    kbmemfree kbmemused  %memused kbbuffers  kbcached kbswpfree 
kbswpused  %swpused  kbswpcad
11:15:53       112488    532788     82.57     74000    260688    497972 
      0      0.00         0
Average:       112488    532788     82.57     74000    260688    497972 
      0      0.00         0


It that is sufficient information for your purposes i can not say, but for 
most people that is all they will ever need.

Regards,
   Dominik Kubla
-- 
Those who can make you believe absurdities can make you commit
atrocities.    (Francois Marie Arouet aka Voltaire, 1694-1778)

