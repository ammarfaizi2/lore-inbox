Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWABVBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWABVBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 16:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWABVBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 16:01:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:53965 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751058AbWABVBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 16:01:46 -0500
Date: Mon, 2 Jan 2006 22:00:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <20060102201325.GA32464@elte.hu>
Message-ID: <Pine.LNX.4.61.0601022158170.14613@yvahk01.tjqt.qr>
References: <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
 <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org>
 <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
 <m3ek3qcvwt.fsf@defiant.localdomain> <Pine.LNX.4.64.0601021105000.3668@g5.osdl.org>
 <20060102201325.GA32464@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>* Linus Torvalds <torvalds@osdl.org> wrote:
>
>> > For example, I add "inline" for static functions which are only called
>> > from one place.
>> 
>> That's actually not a good practice. Two reasons:
>> 
>>  - debuggability goes way down. Oops reports give a much nicer call-chain 
>>    and better locality for uninlined code.

When I want to debug, I use
CFLAGS="-O0 -ggdb3 -fno-inline -fno-omit-frame-pointer"
for that particular file(s). That sure gets good results. Not sure about 
who wins in the kernel case: always_inline or -fno-inline.



Jan Engelhardt
-- 
