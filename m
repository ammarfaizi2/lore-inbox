Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265024AbSKANki>; Fri, 1 Nov 2002 08:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265025AbSKANki>; Fri, 1 Nov 2002 08:40:38 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:41934 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265024AbSKANkg>;
	Fri, 1 Nov 2002 08:40:36 -0500
Message-ID: <3DC285D4.2040305@colorfullife.com>
Date: Fri, 01 Nov 2002 14:47:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: might_sleep() in copy_{from,to}_user and friends?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd wrote:
> I have been looking for more places in 2.5 that can be marked 
> might_sleep() and noticed that all the functions in asm/uaccess.h
> are not marked although they sleep if the memory they access
> has to be paged in.
> 

Good idea.
There is some abuse of __get_user to identify bad pointers:
show_registers in the oops codepath, mm/slab.c in the /proc/slabinfo code.

Could you omit the test from the __ versions?

--
	Manfred

