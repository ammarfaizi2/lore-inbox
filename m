Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268078AbTAJAem>; Thu, 9 Jan 2003 19:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268079AbTAJAem>; Thu, 9 Jan 2003 19:34:42 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:23338 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S268078AbTAJAel>; Thu, 9 Jan 2003 19:34:41 -0500
Message-ID: <3E1E175A.1050109@emageon.com>
Date: Thu, 09 Jan 2003 18:44:10 -0600
From: Brian Tinsley <btinsley@emageon.com>
Organization: Emageon
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@digeo.com>, Chris Wood <cwood@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
References: <3E1A12B5.4020505@xmission.com> <3E1A16C5.87EDE35A@digeo.com> <3E1DAEAC.4060904@xmission.com> <3E1DD913.2571469F@digeo.com> <20030110002548.GG23814@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Either pollwait tables (invisible in 2.4 and 2.5), kernel stacks of
>threads (which don't get pae_pgd's and are hence invisible in 2.4
>and 2.5), or pagecache, with a much higher likelihood of pagecache.
>
The "kernel stacks of threads" may have some bearing on my incarnation 
of this problem. We have several heavily threaded Java applications 
running at the time the live-locks occur. At our most problematic site, 
one application has a bug that can cause hundreds of timer threads (I 
mean like 800 or so!) to be "accidentally" created. This site is 
scheduled for an upgrade either tonight or tomorrow, so I will leave the 
system as it is and see if I can still cause the live-lock to manifest 
itself after the upgrade.

-- 

-[========================]-
-[      Brian Tinsley     ]-
-[ Chief Systems Engineer ]-
-[        Emageon         ]-
-[========================]-



