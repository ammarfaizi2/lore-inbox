Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVGHTlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVGHTlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVGHTi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:38:58 -0400
Received: from falcon30.maxeymade.com ([24.173.215.190]:10942 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S262813AbVGHTfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:35:41 -0400
Message-Id: <200507081935.j68JZSqr003200@falcon30.maxeymade.com>
X-Mailer: exmh version 2.7.2.1 01/17/2005 with nmh-1.1
In-reply-to: <20050708191326.GA6503@elte.hu> 
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption -RT-V0.7.51-17 - Keyboard Problems 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Jul 2005 14:35:28 -0500
From: Doug Maxey <dwm@maxeymade.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 08 Jul 2005 21:13:26 +0200, Ingo Molnar wrote:
>
>* K.R. Foley <kr@cybsft.com> wrote:
>
>> Ingo,
>> 
>> I have an issue with keys VERY SPORADICALLY repeating, SOMETIMES, when 
>> running the RT patches. The problem manifests itself as if the key 
>> were stuck but happens far too quickly for that to be the case. I 
>> realize that the statements above are far from scientific, but I can't 
>> seem to narrow it down further. 2.6.12 doesn't seem to have the 
>> problem at all, only when running the RT patches. It SEEMS to have 
>> gotten worse lately. I am attaching my config as well as the output 
>> from lspci.
>> 
>> Adjusting the delay in the keyboard repeat seems to help. Any ideas?

Is the keyboard standard (PS2) or USB?  Did not see the detail.

>
>hm. Would be nice to somehow find a condition that triggers it. One 
>possibility is that something else is starving the keyboard handling 
>path. Right now it's handled via workqueues, which live in keventd. Do 
>things improve if you chrt keventd up to prio 99? Also i'd chrt the 
>keyboard IRQ thread up to prio 99 too.
>
>the other possibility is some IRQ handling bug - those are usually 
>specific to the IRQ controller, so try turning off (or on) the IO-APIC 
>[if the box has an IO-APIC], does that change anything?

FWIW, I have seen this issue under USB, off and on since about 2.6.9.
Never have dug into it, was always simpler to just unplug and re-plug
the keyboard.  Of course, this predates RT.

++doug

