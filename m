Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269611AbUJLKvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269611AbUJLKvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269618AbUJLKvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:51:21 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:20353 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269611AbUJLKtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:49:49 -0400
Subject: Re: Totally broken PCI PM calls
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <1097553724.7778.34.camel@gaston>
References: <1097455528.25489.9.camel@gaston>
	 <200410110915.33331.david-b@pacbell.net> <1097533363.13795.22.camel@gaston>
	 <200410111946.03634.david-b@pacbell.net>  <1097553724.7778.34.camel@gaston>
Content-Type: text/plain
Message-Id: <1097578189.3728.14.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Oct 2004 20:49:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-10-12 at 14:02, Benjamin Herrenschmidt wrote:

[...]

> An example of the difference between device state and driver state: a
> system "idle" state want devices to be put into some sort of D1 state,
> that is power managed with very fast wakeup. On another hand,
> suspend-to-disk don't care about devices beeing put in any power state
> at all, but the driver must be "frozen" in a consistent state (not
> process requests etc...) so we get a consistent image.

> In the first case, it makes even sense to keep the driver operating
> while the device is D1, the driver would then just wake the device on an
> incoming request (provided this is allowed by the policy). In the later
> case, the driver state is the only thing that matters.

Not quite - you have to be able to get the device into a matching state
at resume time. Probably not a problem in most cases, I realise, but
thought it was worth a mention.

[...]

> Yup, with the exception that it becomes hell when those devices are
> anywhere on the VM path... which makes userspace policy unuseable for
> system suspend.

A device on the VM path? I don't follow here. Can I have a hand please?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

