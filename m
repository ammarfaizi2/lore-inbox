Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbUKQX5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUKQX5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbUKQXzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:55:32 -0500
Received: from alog0025.analogic.com ([208.224.220.40]:33920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262556AbUKQXs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:48:26 -0500
Date: Wed, 17 Nov 2004 18:48:06 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Sharma Sushant <sushant@cs.unm.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: max agruments in system_calls
In-Reply-To: <Pine.LNX.4.60.0411171608250.30215@chawla.cs.unm.edu>
Message-ID: <Pine.LNX.4.61.0411171839430.1111@chaos.analogic.com>
References: <Pine.LNX.4.60.0411171608250.30215@chawla.cs.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Sharma Sushant wrote:

> Hi All
> Can some one tell me, if I want to implement a system call with more than 6 
> arguments in it, how should I do it? I am using kernel 2.6.3.
> I know I can use struct and stuff arguments inside it, but I want to use more
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^__________ yes 
> than 6 different arguments.

Huh? You KNOW that you don't have more than 7 registers available
on ix86 so you KNOW that you either need a pointer to a struct (one 
parameter) or it won't work.

FYI:
 	eax = function code
 	ebx = first parameter
 	ecx = second parameter
 	edx = third parameter
 	esi = fourth parameter
 	edi = fifth parameter
 	ebp = sixth parameter

You need esp for the call and you need eip for the code. There
are no other registers except segment registers.

>
> Thanks
> -Sushant



Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
