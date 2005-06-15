Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVFOQHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVFOQHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 12:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVFOQHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 12:07:16 -0400
Received: from alog0147.analogic.com ([208.224.220.162]:43708 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261206AbVFOQHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 12:07:06 -0400
Date: Wed, 15 Jun 2005 12:06:28 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: 7eggert@gmx.de, Gene Heskett <gene.heskett@verizon.net>,
       cutaway@bellsouth.net, linux-kernel@vger.kernel.org
Subject: Re: .../asm-i386/bitops.h  performance improvements
In-Reply-To: <Pine.LNX.4.61L.0506151629270.13835@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.61.0506151200490.24211@chaos.analogic.com>
References: <4fB8l-73q-9@gated-at.bofh.it> <4fF2j-1Lo-19@gated-at.bofh.it>
 <E1DiZKe-0000em-58@be1.7eggert.dyndns.org> <Pine.LNX.4.61L.0506151629270.13835@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, Maciej W. Rozycki wrote:

> On Wed, 15 Jun 2005, Bodo Eggert wrote:
>
>> lea is an 8086 instruction. All clones have it in it's basic form. However,
>> the multiplicator is not documented for i486, therefore it will be a i586
>> extension.
>
> Huh?  The SIB byte has been added in the original i386 with 32-bit
> addressing.
>
>  Maciej

Well the __documented__ '486 LEA instruction doesn't
even allow the double-register indirect. It's just

 	LEA r16,m
 	LEA r32,m

... repeated twice

Page 26-190,  Intel486(tm) Microprocessor Programmer's Reference
Manual. ISBN 1-55512-195-4. The instruction may have been one
of those "immature features", read broken.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
