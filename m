Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVKBRr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVKBRr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 12:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVKBRr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 12:47:26 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:22022 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751266AbVKBRrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 12:47:25 -0500
Message-ID: <4368FBA6.5040604@superbug.co.uk>
Date: Wed, 02 Nov 2005 17:47:18 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: any fairness in NTPL pthread mutexes?
References: <43665B08.6040005@nortel.com>
In-Reply-To: <43665B08.6040005@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen wrote:
> 
> I'm using NPTL.
> 
> If I have a pthread mutex currently owned by a task, and two other tasks 
> try to lock it, when the mutex is unlocked, are there any rules about 
> the order in which the waiting tasks get the mutex (ie priority, FIFO, 
> etc.)?
> 
> Thanks,
> 
> Chris
> -

There is no fairness at all. It's currently not designed to be fair 
either. The reasons for this I can't remember, but there was talk at the 
KS about it and I just remember the answer. I think it had something to 
do with "If we implement fairness, general locking performance will drop 
and we prefer performance over fairness."

The solution is to modify your program so as not to rely on fairness.

James

