Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTJ3XeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTJ3XeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:34:21 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:40633 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S262982AbTJ3XeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:34:04 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: uptime reset after about 45 days
Date: Thu, 30 Oct 2003 23:34:03 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bns75b$ssn$1@news.cistron.nl>
References: <1067552357.3fa18e65d1fca@secure.solidusdesign.com> <Pine.LNX.4.44.0310310005090.11473-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1067556843 29591 62.216.29.200 (30 Oct 2003 23:34:03 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0310310005090.11473-100000@gaia.cela.pl>,
Maciej Zenczykowski  <maze@cela.pl> wrote:
>> After about 45 days or so, my uptime was reset. My idle time is correct.
>> 
>> $ cat /proc/uptime
>> 94245.37 3686026.54
>> 
>> $ cat /proc/version Linux version 2.4.20-gentoo-r1
>> (root@dpb2.resnet.calvin.edu) (gcc version 3.2.2) #6 SMP Thu Apr 17
>> 14:11:34 EDT 2003
>
>Uptime is stored in jiffies which is 32bit on your arch, which results in 
>an overflow after 2^32 clock ticks. TTTicks were 100 HZ till recently 
>(overflow after 470 or so days) now, they're 1000 -> overflows after 45 
>days.  Doesn't wreck anything except for uptime display - known problem, 

No, that's only on 2.6, and it has been fixed in 2.6 too.
The 2.4 32 bits kernels run with HZ=100.

Sounds like the gentoo-kernel has just upped HZ to 1000 without
fixing these problems properly. That's .. disappointing.

Mike.

