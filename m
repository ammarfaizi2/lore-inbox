Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTFRL5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 07:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbTFRL5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 07:57:05 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:3596 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265153AbTFRL5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 07:57:03 -0400
Message-ID: <3EF05816.6050307@aitel.hist.no>
Date: Wed, 18 Jun 2003 14:16:22 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>, davidm@hpl.hp.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler starvation
References: <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> At 09:53 AM 6/18/2003 +0200, Felipe Alfaro Solana wrote:
> 
>> Hi!
>>
>> I've been poking around and found the following link on O(1) scheduler
>> starvation problems:
>>
>> http://www.hpl.hp.com/research/linux/kernel/o1-starve.php
>>
>> The web page contains a small test program which supposedly is able to
>> make two processes starvate. However, I've been unable to reproduce what
>> is described in the above link. In fact, the CPU usage ratio ranges
>> between 60-40% or 70-30% in the worst cases.
> 
> 
> (you're talking about with my monotinic_clock() diff in your kernel right?)
> 
> If you examine the priorities vs cpu usage, therein lies a big fat bug.
> 
> I think the fundamental problem is that you can only execute in series, 
> but can sleep in parallel, which makes for more sleep time existing than 
> all execution time combined. 

Would dividing the sleep time by the number of sleepers fix this?
Or is division a too heavy operation here?

Helge Hafting

