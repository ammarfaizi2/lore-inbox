Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVBRPZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVBRPZm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVBRPZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:25:41 -0500
Received: from alog0062.analogic.com ([208.224.220.77]:38016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261208AbVBRPZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:25:23 -0500
Date: Fri, 18 Feb 2005 10:24:28 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Paul Fulghum <paulkf@microgate.com>
cc: Paulo Marques <pmarques@grupopie.com>, franck.bui-huu@innova-card.com,
       linux-kernel@vger.kernel.org
Subject: Re: [TTY] 2 points seems strange to me.
In-Reply-To: <4216068E.90205@microgate.com>
Message-ID: <Pine.LNX.4.61.0502181020480.23519@chaos.analogic.com>
References: <20050217175150.D8E015B874@frankbuss.de>
 <20050217181241.A22752@flint.arm.linux.org.uk> <4215B5AC.4050600@innova-card.com>
 <42160290.3070000@microgate.com> <421604DD.4080809@grupopie.com>
 <4216068E.90205@microgate.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005, Paul Fulghum wrote:

> Paulo Marques wrote:
>> Paul Fulghum wrote:
>>> No, it limits the size to 80 bytes,
>>> which is the size of buf.
>>> 
>>> sizeof returns the size of the char array buf[80]
>>> (standard C)
>> 
>> Looking at the code, I think Franck is right. buf is a "const unsigned char 
>> *" for which sizeof(buf) is the size of a pointer.
>
> What kernel version are you looking at?
> I'm looking at 2.4.20 n_tty.c opost_block() and
> buf is a char array.
>
> -- 
> Paul Fulghum
> Microgate Systems, Ltd.

Ahaa!  That's how the bug got introduced. It used to be an
array and then it got changed to a pointer! linux-2.4.26
also shows a local array.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
