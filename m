Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266447AbUFQKfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266447AbUFQKfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUFQKfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:35:46 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:52600 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266447AbUFQKfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:35:43 -0400
Message-ID: <40D173F8.4060701@yahoo.com.au>
Date: Thu, 17 Jun 2004 20:35:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nuno Monteiro <nuno@itsari.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: rwsem-spinlock error
References: <20040616183343.GA9940@logos.cnet> <Pine.GSO.4.58.0406171206470.22919@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0406171206470.22919@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> On Wed, 16 Jun 2004, Marcelo Tosatti wrote:
> 
>><nickpiggin:yahoo.com.au>:
>>  o rwsem race fixes backported from 2.6
> 
> 
>>Nuno Monteiro:
>>  o Fix rwsem-fix typo
>>  o Complete rwsem typo fix
> 
> 
> | rwsem-spinlock.c: In function `__rwsem_wake_one_writer':
> | rwsem-spinlock.c:111: `tsk' undeclared (first use in this function)
> | rwsem-spinlock.c:111: (Each undeclared identifier is reported only once
> | rwsem-spinlock.c:111: for each function it appears in.)
> 
> How can this ever compile on any architecture?
> 

Dangit. rwsem-spinlock.c isn't compiled for many architectures.

It should just require a

	struct task_struct *tsk;

sorry.
