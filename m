Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVCNRHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVCNRHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVCNRHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:07:15 -0500
Received: from alog0162.analogic.com ([208.224.220.177]:3554 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261623AbVCNRGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:06:50 -0500
Date: Mon, 14 Mar 2005 12:03:23 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jakob Eriksson <jakov@vmlinux.org>
cc: Andi Kleen <ak@muc.de>, Stas Sergeev <stsp@aknet.ru>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       wine-devel@winehq.org, torvalds@osdl.org
Subject: Re: [patch] x86: fix ESP corruption CPU bug
In-Reply-To: <4235AC0B.70507@vmlinux.org>
Message-ID: <Pine.LNX.4.61.0503141158460.19270@chaos.analogic.com>
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz>
 <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>
 <Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org> <423518A7.9030704@aknet.ru>
 <m14qfey3iz.fsf@muc.de> <4235AC0B.70507@vmlinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Jakob Eriksson wrote:

> Andi Kleen wrote:
>
>> Stas Sergeev <stsp@aknet.ru> writes:
>> 
>>>> Another way of saying the same thing: I absolutely hate seeing
>>>> patches that fix some theoretical issue that no Linux apps will ever
>>>> care about.
>>>> 
>>> No, it is not theoretical, but it is mainly
>>> about a DOS games and an MS linker, as for
>>> me. The things I'd like to get working, but
>>> the ones you may not care too much about:)
>>> The particular game I want to get working,
>>> is "Master of Orion 2" for DOS.
>>> 
>> 
>> How about you just run it in dosbox instead of dosemu ?
>> 
>
> Yes, that's a solution of course, but it is a bit like saying why
> not use Open Office instead of MS Word.
>
> A long term goal of wine is to support DOS apps to. Of course
> it's not a priority, but it's there.
>
> regards,
> Jakob
>

Can you tell me how the invisible high-word (invisible in VM-86, and
in real mode) could possibly harm something running in VM-86 or
read-mode ???  I don't even think it's a BUG. If the transition
into and out of VM-86 doesn't handle the fact that the high-word
of the stack hasn't been used in VM-86, then that piece of code
is bad (the SP isn't even the same stack, BTW).


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
