Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUGIBDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUGIBDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 21:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUGIBDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 21:03:45 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:28269 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262071AbUGIBDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 21:03:44 -0400
Message-ID: <40EDEEEC.3040109@yahoo.com.au>
Date: Fri, 09 Jul 2004 11:03:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Mikhail Ramendik <mr@ramendik.ru>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       nigelenki@comcast.net, linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       John Richard Moser <nigelenki@comcast.net>
Subject: Re: [ck] Re: [PATCH] Autoregulate swappiness & inactivation
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>	 <cone.1089268800.781084.4554.502@pc.kolivas.org>	 <40ECF278.7070606@yahoo.com.au> <1089306601.2753.13.camel@localhost.localdomain>
In-Reply-To: <1089306601.2753.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikhail Ramendik wrote:
> Nick Piggin wrote:
> 
> 
>>Secondly, can you please not mess with the exported sysctl. If you
>>think your "autoswappiness" calculation is better than the current
>>swappiness one, just completely replace it. Bonus points if you can
>>retain the swappiness knob in some capacity.
> 
> 
> I as a user of -ck *strongly* disagree with this proposal. I want to be
> able to try both manual and automatic setting, without recompiling the
> kernel.
> 
> If you really must avoid another named exported sysctl, I suggest making
> a "reserved" swappiness value, like 255, that would mean
> "auto-regulate".

The point is, there really isn't anything fancy about this
"auto tuning". It just alters the reclaim_mapped formula.

If we decide that the new formula gives better results, then
we should go with that. Exposing an intermediate calculation
in the swappiness sysctl is meaningless.

You can then work out somewhere to input a manual "swappiness"
bias into the new calculation.
