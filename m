Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUDEJix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 05:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUDEJix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 05:38:53 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:59406 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261239AbUDEJiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 05:38:51 -0400
Message-ID: <40712952.6040100@aitel.hist.no>
Date: Mon, 05 Apr 2004 11:39:30 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040404064850.63920.qmail@web40514.mail.yahoo.com>
In-Reply-To: <20040404064850.63920.qmail@web40514.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergiy Lozovsky wrote:
> Hi,
> 
> I have a stack hungry code in the kernel. It hits the
> end of stack from time to time. I wrote function to
> which I pass pointers to function and memory area
> which should be used as stack for function execution.
> (I just load pointer to new stack area into esp
> register). This function works just fine in user space
> and memory area provided by me is used as stack.
> 
> This function doesn't work in the kernel (system hungs
> instantly when my function is called). Does antbody
> have any idea what the reason can be? Some special
> alignment? Special memory segment? In what direction
> should I look?
> 
> (sure I tried some magic with alignment like -
> __attribute__ ((aligned (8192))) - no any effect)
> 
> (there was some patch to increase stack size
> kernelwide, but I don't want to affect all the
> system).


You aren't supposed to need much stack for anything in the kernel.
Consider rewriting your function to use allocated
memory instead of stack, this isn't all that hard.

Helge Hafting

