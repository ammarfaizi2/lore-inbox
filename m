Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270458AbTG1Toh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270479AbTG1Tog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:44:36 -0400
Received: from maild.telia.com ([194.22.190.101]:33237 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S270458AbTG1Toe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:44:34 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: psmouse: synaptics (2.6.0-test1|2)
References: <20030728081832.GA453@schottelius.org>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Jul 2003 21:13:49 +0200
In-Reply-To: <20030728081832.GA453@schottelius.org>
Message-ID: <m265lmihw2.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius <nico-kernel@schottelius.org> writes:

> My questions:
>    3) how can I read /dev/misc/psaux in Linux 2.6 ?

AFAIK, you can't.

>    1) why are you implementing drivers in the kernel?

Because the raw psaux device is no longer exposed to user space.

>    2) what source of information do you use to program them?

The synaptics touchpad interfacing guide. I think this link is still valid:

        http://www.synaptics.com/decaf/utilities/ACF126.pdf

>    3.1) howto get gpm running?

You have to hack gpm to add support for the 2.6 kernel driver. Until
someone fixes gpm you have to use the "psmouse_noext=1" module
option.

>    3.2) is the patch mentioned for X implemented in X cvs?

No, not currently. Aside from technical considerations, there is also
a license problem, because the synaptics driver is GPL:ed, which is
not compatible (I think) with the license used by XFree86. This means
that all copyright holders for the synaptics driver need to agree to
change the license, or their contributions have to be removed and
reimplemented.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
