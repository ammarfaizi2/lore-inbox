Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269991AbUJHObL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269991AbUJHObL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269993AbUJHObK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:31:10 -0400
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:7110 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S269991AbUJHOai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:30:38 -0400
Date: Fri, 8 Oct 2004 16:30:31 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc -align options .config-settable
In-Reply-To: <200410081710.58766.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.60.0410081618530.10253@alpha.polcom.net>
References: <2KBq9-2S1-15@gated-at.bofh.it> <m3pt3t9zaj.fsf@averell.firstfloor.org>
 <200410081710.58766.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2004, Denis Vlasenko wrote:

> On Friday 08 October 2004 12:20, Andi Kleen wrote:
>> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
>>> Resend.
>>>
>>> With all alignment options set to 1 (minimum alignment),
>>> I've got 5% smaller vmlinux compared to one built with
>>> default code alignment.
>>>
>>> Rediffed against 2.6.9-rc3.
>>> Please apply.
>>
>> I agree with the basic idea (the big alignments also always annoy
>> me when I look at disassembly), but I think your CONFIG options
>> are far too complicated. I don't think anybody will go as far as
>> to tune loops vs function calls.
>>
>> I would just do a single CONFIG_NO_ALIGNMENTS that sets everything to
>> 1, that should be enough.
>
> For me, yes, but there are people which are slightly less obsessed
> with code size than me.
>
> They might want to say "try to align to 16 bytes if
> it costs less than 5 bytes" etc.
>
> Also bencmarking people may do little research on real usefulness of
> various kinds of alignment.

I think that removing aligns completly will be very bad. I am Gentoo user 
and I set my user space CFLAGS for all system to -falign-loops 
-fno-align-<everything else>. I did not tested it in depth, but my simple 
tests show that unaligning loops is a very bad idea. Unaligning functions 
is safer since small and fast functions should be always inlined.


Thanks,

Grzegorz Kulewski

