Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWILVV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWILVV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWILVV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:21:26 -0400
Received: from bcp12.neoplus.adsl.tpnet.pl ([83.27.231.12]:41372 "EHLO
	Jerry.zjeby.dyndns.org") by vger.kernel.org with ESMTP
	id S1751348AbWILVVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:21:25 -0400
Date: Tue, 12 Sep 2006 23:21:24 +0200 (CEST)
From: Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: thinkpad 360Cs keyboard problem
In-Reply-To: <d120d5000609121012o684a098bx6bc2d497a17b1421@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0609121950381.2685@Jerry.zjeby.dyndns.org>
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org> 
 <Pine.LNX.4.63.0609102137240.2685@Jerry.zjeby.dyndns.org> 
 <20060910194955.GA1841@elf.ucw.cz>  <200609102054.34350.dtor@insightbb.com>
  <Pine.LNX.4.63.0609120209590.2685@Jerry.zjeby.dyndns.org> 
 <d120d5000609120705r26a25b44q7533c528bccb25bf@mail.gmail.com> 
 <Pine.LNX.4.63.0609121611380.2685@Jerry.zjeby.dyndns.org>
 <d120d5000609121012o684a098bx6bc2d497a17b1421@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006, Dmitry Torokhov wrote:

> On 9/12/06, Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org> wrote:
>>  On Tue, 12 Sep 2006, Dmitry Torokhov wrote:
>> 
>> >  On 9/11/06, Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org> wrote:
>> 
>> > >   kernel boots up fine, but keyboard is totally messed up,
>> > >   and locks up after some tries of use.
>> > 
>> >  Could you try describing the exact issues with the keyboard? Missing
>> >  keypresses, wrong keys reported, etc?
>>
>>  with prink enabled it prints series of 'unknown scancode'
>>  and keys are randomly messed up, and it changes, so like pressing b
>>  results with n, then space, then nothing at all.
>>  after some tries keyboard locks up completely.
>> 
>
> Are you loading a custom keymap by any chance? Could I please see
> dmesg with "i8042.debug log_buf_len=131072"?

no custom keymaps . init=/bin/bash :d
uhm, i don't get what you mean by this dmesg syntax :o
i should probably attach serial conole and send you whole output,
as now (as keyboard is unuseable) i can't scroll screen.

btw. serio: i8042 KBD port at 0x60,0x64 irq 1
is found.
also
input: AT Raw Set 2 keyboard as /class/input/input1
is reported

ah, i use gcc-4.1.1 to compile kernel .


-------------------- stuff below might be result of my ignorance

i just checked 2.2.27 kernel. it behaves quite identical to 2.4.33.3,
just after 'freeing unused kernel memory' it touches disk , and just
sits there. kepresses are echoed, and keyboard output is 
ok. i can reboot it by ctrl-alt-delete too .
when i boot it with 'fosh' shell commandline appears, but trying
to use any tool like bash, ls , etc results with signal 11.
tools are statically compiled against glibc-2.4 (compiled for 486 cpu
on gentoo)
busybox works fine.

on 2.4.33.3 kernel Xvesa (from kdrive package) complains
'set_thread_area failed when setting up thread-local storage'

cardmgr works fine aswell...(though was linked against different glibc)
  i guess there is some problem with math emulation and glibc,
as on 2.6.18 everything works just fine.

i recall few years ago i tried to make 386SX work on 2.4.20 , and 
there were problems with math emulation (some apps worked, some not)






