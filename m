Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbUDMRKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbUDMRKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:10:53 -0400
Received: from p50829858.dip.t-dialin.net ([80.130.152.88]:47884 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S263627AbUDMRKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:10:43 -0400
Date: Tue, 13 Apr 2004 17:00:27 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Miles Bader <miles@gnu.org>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, rth@twiddle.net,
       spyro@f2s.com, rmk@arm.linux.org.uk, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [1/3]
Message-ID: <20040413170027.A6693@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Miles Bader <miles@gnu.org>, davidm@hpl.hp.com,
	linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
	rmk@arm.linux.org.uk, paulus@au.ibm.com, benh@kernel.crashing.org,
	jes@trained-monkey.org, ralf@gnu.org, matthew@wil.cx,
	davem@redhat.com, wesolows@foobazco.org, jdike@karaya.com,
	ak@suse.de
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org> <20040412075704.B5198@Marvin.DL8BCU.ampr.org> <16506.50767.128817.828166@napali.hpl.hp.com> <20040412200835.A5625@Marvin.DL8BCU.ampr.org> <16506.64729.917048.491827@napali.hpl.hp.com> <20040412211754.A5770@Marvin.DL8BCU.ampr.org> <buofzb8o75c.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <buofzb8o75c.fsf@mcspd15.ucom.lsi.nec.co.jp>; from miles@lsi.nec.co.jp on Tue, Apr 13, 2004 at 01:04:31PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 01:04:31PM +0900, Miles Bader wrote:
> Thorsten Kranzkowski <dl8bcu@dl8bcu.de> writes:
> > Since INPUT_PCSPKR seems to be available on all archs, every arch must
> > have some idea of PI[CT]_TICK_RATE, no?
> 
> What are you talking about?  I see no INPUT_PCSPKR defined on my arch

drivers/inkut/Kconfig:
	menu "Input device support"

	config INPUT
		tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
		default y
	[...]

	source "drivers/input/misc/Kconfig"

drivers/input/misc/Kconfig:
	config INPUT_MISC
		bool "Misc"
		depends on INPUT
	[...]
	config INPUT_PCSPKR
		tristate "PC Speaker support"
		depends on INPUT && INPUT_MISC


I'm by no means a Kconfig expert, but I read this as there's nothing 
that prevents you to select INPUT_PCSPKR on every architecture.

I don't know your architecture, maybe it doesn't have a system speaker.

> anywhere, and don't even know what an 8253 is... [so it would be damn
> silly to have <asm/8253pit.h> as a required header!]

Ok, I won't create one, then. (just to be shure: asm-v850, right?) 

> Don't assume everything is like a PC.

Hell, no! I actually like my Alphas! ;)

Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
