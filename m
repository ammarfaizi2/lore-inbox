Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUJHVam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUJHVam (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUJHVam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:30:42 -0400
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:27592 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S265331AbUJHVak
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:30:40 -0400
Date: Fri, 8 Oct 2004 23:30:34 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc -align options .config-settable
In-Reply-To: <200410082342.40682.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.60.0410082319170.17797@alpha.polcom.net>
References: <2KBq9-2S1-15@gated-at.bofh.it> <200410081710.58766.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.60.0410081618530.10253@alpha.polcom.net>
 <200410082342.40682.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2004, Denis Vlasenko wrote:

> On Friday 08 October 2004 17:30, Grzegorz Kulewski wrote:
>>> Also bencmarking people may do little research on real usefulness of
>>> various kinds of alignment.
>>
>> I think that removing aligns completly will be very bad. I am Gentoo user
>> and I set my user space CFLAGS for all system to -falign-loops
>> -fno-align-<everything else>. I did not tested it in depth, but my simple
>> tests show that unaligning loops is a very bad idea. Unaligning functions
>
> That depends on how often that loop runs. 90% of code runs only
> 10% of time. I think ultimately we want to mark other 10% of code with:

Well, loops should probably always be aligned because aligning them will 
not make the code significantly larger (I think, I did not mensure it), 
but it will make the code significantly faster, and more friendly to
processor's cache.


>> is safer since small and fast functions should be always inlined.
>
> Concept of alignment does not apply to inlined functions at all.

That is my point. It is safe not to align functions because fast and often 
called ones will be inlined and will not be slowed down by lack of 
alignment.


Thanks,

Grzegorz Kulewski

