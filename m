Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVBRPUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVBRPUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVBRPUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:20:51 -0500
Received: from alog0062.analogic.com ([208.224.220.77]:36736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261208AbVBRPUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:20:45 -0500
Date: Fri, 18 Feb 2005 10:19:56 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Paulo Marques <pmarques@grupopie.com>
cc: franck.bui-huu@innova-card.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [TTY] 2 points seems strange to me.
In-Reply-To: <421604DD.4080809@grupopie.com>
Message-ID: <Pine.LNX.4.61.0502181014020.23519@chaos.analogic.com>
References: <20050217175150.D8E015B874@frankbuss.de>
 <20050217181241.A22752@flint.arm.linux.org.uk> <4215B5AC.4050600@innova-card.com>
 <42160290.3070000@microgate.com> <421604DD.4080809@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005, Paulo Marques wrote:
> Franck Bui-Huu wrote:
> 
>> Looking at TTY code, I noticed a weird test done in "opost_bock"
>> located in n_tty.c file. I don't understand why the following test is
>> done at the start of the function:
>> if (nr > sizeof(buf))
>>        nr = sizeof(buf);
>> Actually it limits the size of processing blocks to 4 bytes and I can't
>> find a reason why.
> 
> No, it limits the size to 80 bytes,
> which is the size of buf.
> 
> sizeof returns the size of the char array buf[80]
> (standard C)
>

Huh?? "buf" is a pointer. On this system pointers are 4-bytes
in length. What "standard C" are you using? Frank found a bug.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
