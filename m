Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267646AbUIJR4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267646AbUIJR4a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUIJR4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:56:02 -0400
Received: from mail.tmr.com ([216.238.38.203]:2323 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267689AbUIJRx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:53:56 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Date: Fri, 10 Sep 2004 13:54:16 -0400
Organization: TMR Associates, Inc
Message-ID: <chspak$bla$1@gatekeeper.tmr.com>
References: <1094807650.17041.3.camel@localhost.localdomain><1094807650.17041.3.camel@localhost.localdomain> <593560000.1094826651@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1094838421 11946 192.168.12.100 (10 Sep 2004 17:47:01 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <593560000.1094826651@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Friday, September 10, 2004 10:14:11 +0100):
> 
> 
>>On Gwe, 2004-09-10 at 07:40, Arjan van de Ven wrote:
>>
>>>Well I always assumed the future plan was to remove 8k stacks entirely;
>>>4k+irqstacks and 8k basically have near comparable stack space, with
>>>this patch you create an option that has more but that is/should be
>>>deprecated. I'm not convinced that's a good idea.
>>
>>Its probably appropriate to drop gcc 2.x support at that point too since
>>it's the major cause of remaining problems
> 
> 
> What problems does it cause? 2.95.4 still seems to work fine for me.

The RH7.3 remnant 2.96 seems to work for me on my expendable test box, 
and I don't really have space for an upgrade. I haven't seen any 
problems, other than old systems being dog slow. And gcc3 is even slower 
it seems, although my machines running that have enough CPU to pretty 
much overpower the bloat.
> 
> I agree about killing anything but 4K stacks though - having the single
> page is very compelling - not only can we allocate it easier, but we can
> also use cache-hot pages from the hot list.

I have no problems with making 4k the default, but I'd really like the 
option of going back to 8k when I see problems, just to eliminate that 
as a possible cause of hangs or other instances of evil.

Is everyone claiming that everything in the kernel is 4k safe now? Or is 
"stable" total fiction? The 8k code doesn't take up that much space, it 
is well tested, and if you make 4k the default most people will try it 
with 4k anyway.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
