Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269930AbRHEHQ4>; Sun, 5 Aug 2001 03:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269931AbRHEHQq>; Sun, 5 Aug 2001 03:16:46 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:26386 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269930AbRHEHQb>;
	Sun, 5 Aug 2001 03:16:31 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /proc/ksyms change for IA64 
In-Reply-To: Your message of "Sun, 05 Aug 2001 15:44:45 +1000."
             <E15TGiV-0008WI-00@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Aug 2001 17:16:33 +1000
Message-ID: <13470.996995793@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Aug 2001 15:44:45 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>In message <22165.996722560@kao2.melbourne.sgi.com> you write:
>> The IA64 use of descriptors for function pointers has bitten ksymoops.
>> For those not familiar with IA64, &func points to a descriptor
>> containing { &code, &data_context }.  System.map contains the address
>> of the code, /proc/ksyms contains the address of the descriptor.
>> insmod needs the descriptor address, ksymoops and debuggers need the
>> code address, /proc/ksyms needs to contain both addresses, with one of
>> them prefixed by a special character.
>
>Eewwww....
>
>	How about just adding /proc/ksyms-ia64 with the code pointers
>which contains the ia64 code addresses required by ksymoops and
>debuggers.  These are, after all, less vital than insmod.

That requires changes to every kernel debugger, oops decoder etc.  I
don't control all of Linux debugging yet ;).  It is also more work
because it requires kernel changes as well as lots of user space.

BTW, do you know that you are sending from 144.137.82.79 which has no reverse
DNS?  Oh wait, it's Telstra :(

Welcome to Telstra country, on any day you can hear the customers being
ripped off.
