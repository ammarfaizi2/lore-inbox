Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTIHQnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTIHQnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:43:52 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:20362 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262736AbTIHQnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:43:50 -0400
Message-ID: <3F5CB218.5030203@softhome.net>
Date: Mon, 08 Sep 2003 18:45:12 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nasm over gas?
References: <rZQN.83u.21@gated-at.bofh.it> <saVL.7lR.1@gated-at.bofh.it> <soFo.16a.1@gated-at.bofh.it> <ssJa.6M6.25@gated-at.bofh.it> <tcVB.rs.3@gated-at.bofh.it> <3F5C7009.4030004@softhome.net> <20030908161729.GB26829@mail.jlokier.co.uk>
In-Reply-To: <20030908161729.GB26829@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Ihar 'Philips' Filipau wrote:
> 
>>  It will depend on arch CPU only in case if you have unlimited i$ size.
>>  Servers with 8MB of cache - yes it is faster.
>>  Celeron with 128k of cache - +4bytes == higher probability of i$ miss 
>>== lower performance.
> 
> Higher probability != optimal performance.
> 
> It depends on your execution context.  If it's part of a tight loop
> which is executed often, then saving a cycle in the loop gains more
> performance than saving icache, even on a 128k Celeron.
> 

   You think as system-programmer.
   Every bit of i$ waste - hit user space applications too.
   128k of $ - is for every app.

   If you gained one cycle by polluting one more cache line - do not 
forget that this cache line probably contained some info, which was able 
to avoid cache miss for another application. So you gained cycle here - 
and lost it immediately in another app. Not good.

   If you can improve performance by NOT polluting cache - it would be 
another story :-)))

> The execution context can depend on the input to the program, in which
> case the faster of the two code sequences can depend on the program's
> input too.  Then, for optimal performance, you need to profile the
> "expected" inputs.
> 
> 
> You obviously have not read the GAS documentation.
> 
> It has quite a good macro facility built in.
> 

   Indeed. RTFM quickly shown some good examples.

   But still I never saw this kind of thing being used in kernel. 
Instead of writing normal asm we have something like i386/mmx.c. And 
i386/checksum.S not the best sample of asm in kernel too. Sad.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
   * Please avoid sending me Word/PowerPoint/Excel attachments.
   * See http://www.fsf.org/philosophy/no-word-attachments.html
   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
    There should be some SCO's source code in Linux -
       my servers sometimes are crashing.      -- People

