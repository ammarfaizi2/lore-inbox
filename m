Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUIVTxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUIVTxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUIVTxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:53:23 -0400
Received: from mail.aknet.ru ([217.67.122.194]:19470 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S266786AbUIVTw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:52:57 -0400
Message-ID: <4151DA79.7000804@aknet.ru>
Date: Thu, 23 Sep 2004 00:03:05 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru> <Pine.LNX.4.53.0409221501440.1085@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.53.0409221501440.1085@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard B. Johnson wrote:
> What problem is this supposed to fix?
Richard, it will really help if you read the
whole thread. I was answering this to Denis
Vlasenko already - he agreed. Do I have to
repeat the explanations?

> ESP is __not__ corrupted
Right, but is not properly restored either,
while it have to be.

> when returning to protected-mode or a different privilege level.
It gets "corrupted" (not properly restored)
exactly when returning to *protected mode*
from another priv level. Please refer to the
Intel docs I pointed to in that thread earlier.

> You don't 'return' to protected mode from a virtual-8086 mode,
Noone was speaking about v86. I don't see why
you pick that up.

> The so-called bug is that when in real mode or in virtual-8086
> mode, the high word of ESP is not changed.
In short: Wrong.
The complete explanations are easily locateable
in that thread. And it have nothing to do with
the real mode either.

> It is not a bug
> because the high word doesn't even exist when in VM-86 mode!!
Noone was speaking about v86, sorry. I am bypassing
that part.

> It is possible to use the 32-bit prefix, when in 16-bit mode,
That's not about the prefixes either, sorry.
We were talking about the 32bit PM code.

> Please, somebody from Intel tell these guys to leave the thing
> alone.
Thanks many, they already left that alone once:)
Maybe enough of leaving the bugs alone?
I have lots of the DOS progs here that do not
work under dosemu without that patch, and work
perfectly with it. It should be enough. If
you need an examples - well, OpenCubicPlayer
for one. It will start, but crash as soon as
the music is attempted to play. The patch fixes
it. Other progs you'll have problems downloading
anyway, but let me know if you need these.

> I, for one, don't want a bunch of "fixes" that do nothing
> except consume valuable RAM, making it near impossible to
> use later versions of Linux in embedded systems.
Well, my patch is purely in asm. How many
valueable bytes does it take from you?
As for performance - 8 asm insns on a generic
path. Not too much either, as for me.

