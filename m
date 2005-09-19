Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932721AbVISWj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbVISWj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbVISWj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:39:27 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:461 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932721AbVISWj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:39:26 -0400
Message-ID: <432F3E0F.1010002@nortel.com>
Date: Mon, 19 Sep 2005 16:39:11 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>	 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com> <1127168232.24044.265.camel@tglx.tec.linutronix.de>
In-Reply-To: <1127168232.24044.265.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2005 22:39:15.0128 (UTC) FILETIME=[F6983380:01C5BD6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:

> We should rather ask glibc people why gettimeofday() / clock_getttime()
> is called inside the library code all over the place for non obvious
> reasons.

 From an app point of view, there are any number of reasons to check the 
time frequently.

--debugging
--flight-recorder style logs
--if you've got timers in your application, you may want to check to 
make sure that you didn't get woken up early (the linux behaviour of 
returning unused time in select is not portable)
--the app might be tracking it's own behaviour, measuring how long code 
paths take for its own accounting purposes
--emulators (vmware, UML, etc.) often want to check the time quite 
frequently


Chris
