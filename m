Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318388AbSGYJww>; Thu, 25 Jul 2002 05:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318389AbSGYJww>; Thu, 25 Jul 2002 05:52:52 -0400
Received: from [195.63.194.11] ([195.63.194.11]:3079 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S318388AbSGYJwv>;
	Thu, 25 Jul 2002 05:52:51 -0400
Message-ID: <3D3FC9F0.5040809@evision.ag>
Date: Thu, 25 Jul 2002 11:50:40 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.28
References: <Pine.LNX.4.44.0207251126120.20754-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> On Wed, 24 Jul 2002, David S. Miller wrote:
> 
> 
>>I really think it is unwise to even imply that this kind of cli/sti
>>fixup can be done in some mindless manner, it really can't :-)
> 
> 
> i think the networking code is a special case - nothing else relies on the
> interaction of timers and IRQ contexts in such a deep way. (which it does
> for performance reasons.) I'd say 99% of all cli()/sti() users are in the
> 'introduce a per-driver or per-subsystem lock' league Linus mentioned.

Carefull.... The ATA host controller patches showed that mindless fixing
would just hide the fact that, well let me  guess, 50% of cli() sti()
are remnants from the days we didn't even have spin locks or
are simple used becouse somone feeled like he needs "kind of safety"
and wanted to make some thing "bullet proof".. And it's easier to see 
this kind of aplication on cli() then on "carefully" added spinlocking. 
Becouse in the case of spinlocks there is always a chance that they 
interact with some code you don't see when looking at a particular place 
of usage of course...



