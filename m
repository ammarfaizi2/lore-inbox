Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUDLUS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbUDLUSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 16:18:55 -0400
Received: from pD9E57A79.dip.t-dialin.net ([217.229.122.121]:9739 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S263062AbUDLUSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 16:18:53 -0400
Date: Mon, 12 Apr 2004 20:11:57 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [0/3]
Message-ID: <20040412201156.B5625@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
	rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
	benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
	matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
	jdike@karaya.com, ak@suse.de
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org> <Pine.LNX.4.58.0404121246310.18930@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.58.0404121246310.18930@montezuma.fsmlabs.com>; from zwane@linuxpower.ca on Mon, Apr 12, 2004 at 12:47:08PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 12:47:08PM -0400, Zwane Mwaikambo wrote:
> On Mon, 12 Apr 2004, Thorsten Kranzkowski wrote:
> 
> > With every 2.6 kernel I tried the system speaker on my Alpha produces a
> > rather unpleasant high pitched tone instead of the normal system beep.
> > This is because in p|cspkr.c the calculation of the counter values is
> > incorrectly based on CLOCK_TICK_RATE.
> > To solve this problem I came up with these tree patches:
> >
> > 1/3:	introduce PIC_TICK_RATE constant. It seems this is not always
> > 	the same value.
> > 2/3:	use PIC_TICK_RATE in *spkr.c and some other places where the
> > 	PIC is directly programmed.
> > 3/3:	use CLOCK_TICK_RATE where 1193180 was used in timing calculations.
> >
> > Tested on Alpha, compile & boot-tested on i386 (unrelated LVM problems here)
> >
> > Arch maintainers please have a look whether I got the constants right or
> > if your architecture has a PIC at all.
> 
> Isn't this supposed to be PIT_TICK_RATE?
 

I reused the define in arch/alpha/kernel/time.c that served exactly 
the same purpose. I have no problems to call this a timer instead
of a counter, though. :)


Bye,
Thorsten


-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
