Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVC3UPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVC3UPo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVC3UOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:14:23 -0500
Received: from smtp9.poczta.onet.pl ([213.180.130.49]:29649 "EHLO
	smtp9.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262453AbVC3UNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:13:43 -0500
Message-ID: <424B090F.3090508@poczta.onet.pl>
Date: Wed, 30 Mar 2005 22:16:15 +0200
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
References: <fa.ed33rit.1e148rh@ifi.uio.no>	<E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>	<424ACEA9.6070401@poczta.onet.pl>	<yw1xpsxhvzsz.fsf@ford.inprovide.com>	<424AE18B.1080009@poczta.onet.pl> <yw1xll85vtva.fsf@ford.inprovide.com>
In-Reply-To: <yw1xll85vtva.fsf@ford.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
>
> You could wrap /lib/ld-linux.so, and get all dynamically linked
> programs done in one sweep.
>
That's mad idea - keep similar things in one place! starting programs is 
done in kernel and nice-value-support is also done in kernel!!

> 
> Using a shell to run external programs is quite common.  The system()
> and popen() functions both invoke the shell.
> 
Yes, but compexity of 'sh -c /some/command' is uncomparable to one of 
shell-level-program-renicing system. such system should keep database of 
reniced processes, parse it (using awk or sed, i'm afraid...) and then 
renice process (what also takes two files[!, they are in fact 
one-liners, but it is needed to gain root privileges to renice 
process]). sorry, but linux works smoothly on 386, and such mess would 
surely change it.

> 
> I'm not so sure it belongs at all.  The can of worms it opens up is a
> bit too big, IMHO.
> 
What can? the only account that have access to renicing field is root. 
if some-malicious-person can gain access to root account, he does not 
need renicing field, because he can renice processes by snice tool! for 
normal user, this field is unchangeable. of course, if root is so <....> 
to set inpropertly nice field, he is propably also about to set setuid 
to /bin/[ba]sh and set root's password to '123'... I really do not see 
any dangers of providing such feature in kernel (b[u]y the way - 
renicing in user space requires root privileges, so [from security point 
of view] it doesn't really matter where renicing is done - both in 
kernel and userland it has full-access to the system)

thx for replies

--
wixor
May the Source be with you.
