Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWIYNX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWIYNX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 09:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWIYNX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 09:23:58 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:63568 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750727AbWIYNX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 09:23:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3XmMDjTx+gLOLtR6DD8IrdviLhW/KHDrpNwGhwX7FoMIBnytBF67xUfdq71kUb1J+LicJHV/8Vt39Au8Baj07nc+RzMzMIOdYRGmGeFqGlfsCbe26iZZhhxm/iqOizfV5TiuzGFXwTxAaYcXZdtU6PUJUKRrpPIiHuxZLR5ocNU=  ;
Message-ID: <451757BE.3070802@yahoo.com.au>
Date: Mon, 25 Sep 2006 14:14:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Weiske <cweiske@cweiske.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference
 at virtual address 000,0000a
References: <45155915.7080107@cweiske.de>	<20060923134244.e7b73826.akpm@osdl.org>	<451677FE.2070409@cweiske.de> <20060924095029.0262a2c8.akpm@osdl.org> <4516C4B9.5010509@cweiske.de>
In-Reply-To: <4516C4B9.5010509@cweiske.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Weiske wrote:

>Andrew,
>
>
>
>>I assume that you have confirmed that the machine doesn't have hardware
>>problems?  Does it run some earlier kernel OK?  
>>
>The disks are both fine, they worked in other pcs without problems. The
>ide controller card also worked fine, and the motherboard is new -
>whatever you can expect with that. Maybe the combination is the problem.
>

Memory, motherboard, and CPU would be possible candidates, in roughly
that order of likelihood. If you can run memtest86+ on it overnight,
that would provide a bit more confidence in all.

Can you try using a different IDE controller to reproduce the panic
on the same system?

>>And how long does it take to crash?
>>
>After starting the yacy daemon, it's about half a minute until the
>"possible recursive locking detected" appears, and after one or two
>minutes the whole thing crashes.
>

I wonder if that does anything unusual apart from use the network?
Can you break it with anything else? a big ftp transfer?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
