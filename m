Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUDLVY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUDLVY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:24:59 -0400
Received: from p50829858.dip.t-dialin.net ([80.130.152.88]:38667 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S263101AbUDLVY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:24:58 -0400
Date: Mon, 12 Apr 2004 21:17:54 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, paulus@au.ibm.com, benh@kernel.crashing.org,
       jes@trained-monkey.org, ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
       wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [1/3]
Message-ID: <20040412211754.A5770@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
	rth@twiddle.net, spyro@f2s.com, rmk@arm.linux.org.uk,
	paulus@au.ibm.com, benh@kernel.crashing.org, jes@trained-monkey.org,
	ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
	wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org> <20040412075704.B5198@Marvin.DL8BCU.ampr.org> <16506.50767.128817.828166@napali.hpl.hp.com> <20040412200835.A5625@Marvin.DL8BCU.ampr.org> <16506.64729.917048.491827@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <16506.64729.917048.491827@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Mon, Apr 12, 2004 at 01:32:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 01:32:25PM -0700, David Mosberger wrote:
> Yes, a #define is probably needed, but I do think timex.h is the wrong
> place.  Perhaps <asm/8253pit.h> along with a suitable CONFIG_8253PIT
> Kconfig option?

The header is fine with me but what do you have in mind with the Kconfig
option? where should it be used? 
Since INPUT_PCSPKR seems to be available on all archs, every arch must
have some idea of PI[CT]_TICK_RATE, no?

Thanks for your comments, I'll rework my patch tomorrow.

Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
