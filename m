Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTEUTFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 15:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbTEUTFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 15:05:35 -0400
Received: from octopus.com.au ([61.8.3.8]:526 "EHLO octopus.com.au")
	by vger.kernel.org with ESMTP id S262275AbTEUTFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 15:05:34 -0400
Message-ID: <3ECBD0EA.70307@octopus.com.au>
Date: Thu, 22 May 2003 05:18:02 +1000
From: Duraid Madina <duraid@octopus.com.au>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030512
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
References: <16075.8557.309002.866895@napali.hpl.hp.com>	 <1053507692.1301.1.camel@laptop.fenrus.com>	 <3ECB57A4.1010804@octopus.com.au> <1053522732.1301.4.camel@laptop.fenrus.com>
In-Reply-To: <1053522732.1301.4.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> if you had spent the time you spent on this colorful graphic on reading
> SUS or Posix about what sched_yield() means

Quoth the man page,

"A process can relinquish the processor voluntarily without blocking by 
calling sched_yield. The process will then be moved to the end of the 
queue for its static priority and a new process gets to run."

How you get from there to "I'm the least important thing in the system" 
is, once again, beyond me. And even if that were a reasonable 
interpretation of the word 'yield', you would still hope that more than 
one CPU would get something to do if there was enough work to go around. 
Agreed, "spinning" on sched_yield is a very naive way of doing 
spinlocks. But that doesn't change the fact that it's a simple and 
correct way. One would have hoped that calling sched_yield every few 
million cycles wouldn't break the scheduler.

	Duraid

