Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUD2Kob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUD2Kob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 06:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUD2Kob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 06:44:31 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:57718 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262080AbUD2Ko3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 06:44:29 -0400
Message-ID: <4090DC89.6060603@yahoo.com.au>
Date: Thu, 29 Apr 2004 20:44:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Marc Singer <elf@buici.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040429005801.GA21978@buici.com> <40907AF2.2020501@yahoo.com.au> <20040429042047.GB26845@buici.com> <20040429083608.A8169@flint.arm.linux.org.uk>
In-Reply-To: <20040429083608.A8169@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Apr 28, 2004 at 09:20:47PM -0700, Marc Singer wrote:
> 
>>Russell King is working on a lot of things for the MMU code in ARM.
>>I'm waiting to see where he ends up.  I believe he's planning on
>>removing the lazy PTE release logic.
> 
> 
> Essentially it came to a grinding halt due to the shere size of the
> task of sorting out the crappy includes, which is far to large for a
> stable kernel.
> 
> I may go back to the original problem and sort it a different way,
> but for the time being, I'm occupied in other areas.
> 

Anyway, Marc said he tried flushing the tlb and that didn't
solve his problem.

The problem might be the one identified in the thread:
2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page writeback
