Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWEGM4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWEGM4V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 08:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWEGM4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 08:56:21 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:19790 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932144AbWEGM4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 08:56:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=clxqJlU2HUXEvmPkQrmCHbvYc3mjCWRoOYMQgNcqfl0XFW0LGJAEHxJXdYB/d9uDTJ2N4cnc5LEVDy5vAT27kJadkV35MTwxVKqvk5Ae2ngqSGYcckpi1QgQBmH3PDqMq9X/Vcg/z+GQb4c1L3jT3ptReJuuj17b38SVKDx6LpY=  ;
Message-ID: <445DEE70.10807@yahoo.com.au>
Date: Sun, 07 May 2006 22:56:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Mike Galbraith <efault@gmx.de>, Andi Kleen <ak@suse.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com> <200605021859.18948.ak@suse.de> <445791D3.9060306@yahoo.com.au> <1146640155.7526.27.camel@homer> <445DE925.9010006@yahoo.com.au> <20060507124307.GA20443@flint.arm.linux.org.uk>
In-Reply-To: <20060507124307.GA20443@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, May 07, 2006 at 10:33:41PM +1000, Nick Piggin wrote:
> 

>>No, sched_clock is fine to be used in CPU scheduling choices, which are
>>heuristic anyway (although strictly speaking, even using it for timeslicing
>>within a single CPU could cause slight unfairness).
> 
> 
> Except maybe if it rolls over every 178 seconds, which is my original
> point.  Maybe someone could comment on my initial patch sent 5 days
> ago?

Well yes that's true. I meant the "sched_clock interface as defined". Now
there are obviously issues (including the one you raised) that makes the
sched_clock interface unreasonable to implement.

I stand by my first reply to your comment WRT the API. Seems like most of
the rest of the debate was unrelated or concerning implementation details.
kernel/sched.c patches implementing the new API would get an ack from me.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
