Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266220AbUGJMDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUGJMDt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUGJMDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:03:49 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:15765 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266220AbUGJMDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:03:42 -0400
Message-ID: <40EFDB18.404@yahoo.com.au>
Date: Sat, 10 Jul 2004 22:03:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: FabF <fabian.frederick@skynet.be>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: rss recovery
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>	 <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>	 <cone.1089268800.781084.4554.502@pc.kolivas.org>	 <20040708001027.7fed0bc4.akpm@osdl.org>	 <cone.1089273505.418287.4554.502@pc.kolivas.org>	 <20040708010842.2064a706.akpm@osdl.org>	 <cone.1089275229.304355.4554.502@pc.kolivas.org>	 <1089284097.3691.52.camel@localhost.localdomain>	 <40EDEF68.2020503@kolivas.org>	 <1089366486.3322.10.camel@localhost.localdomain>	 <40EE76CC.5070905@yahoo.com.au>	 <1089371646.3322.38.camel@localhost.localdomain>	 <40EE8075.6060700@yahoo.com.au>	 <1089452697.3646.11.camel@localhost.localdomain>	 <40EFC076.9050504@yahoo.com.au> <1089457076.3646.33.camel@localhost.localdomain>
In-Reply-To: <1089457076.3646.33.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF wrote:
> Nick,
> 	Putting some more pressure I finally saw the awaited behaviour from np
> : rss gaining 1MB (or at least 1 byte :) : top reports 10M -> 11M )
> directly after make was done with 10 threads.
> 
> But I guess it can do much better than that (IOW recover original rss).
> Where does re-attribution takes place in np ?
> 

I don't do any sort of preemptive RSS recovery. The pagein mechanisms
are unchanged with my patch. The point was that mozilla no longer got
swapped out by updatedb, isn't that what you wanted?
