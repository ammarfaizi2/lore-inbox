Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268892AbTBZTqU>; Wed, 26 Feb 2003 14:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268891AbTBZTqU>; Wed, 26 Feb 2003 14:46:20 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15890 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268892AbTBZTqS>; Wed, 26 Feb 2003 14:46:18 -0500
Date: Wed, 26 Feb 2003 14:56:22 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Rhodes, Tom" <tom.rhodes@hp.com>
Cc: jbourne@mtroyal.ab.ca, zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: lockups with 2.4.20 (tg3? net/core/dev.c|deliver_to_old_ones)
Message-ID: <20030226145622.C26604@devserv.devel.redhat.com>
References: <DC900CF28D03B745B2859A0E084F044D043506DD@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <DC900CF28D03B745B2859A0E084F044D043506DD@cceexc19.americas.cpqcorp.net>; from tom.rhodes@hp.com on Wed, Feb 26, 2003 at 09:29:56AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 26 Feb 2003 09:29:56 -0600
> From: "Rhodes, Tom" <tom.rhodes@hp.com>

> > there is a deadlock: deliver_to_old_ones()attempts to stop all timers

> Until this is fixed, there are a couple work-arounds:
> - Put the system behind a NAT firewall. [...]
> - Switch to a non-NAPI driver. [...]

I think you are a little late with these workarounds, tg3 1.4c
is available for a week already.
 http://people.redhat.com/jgarzik/tg3/tg3-1.4c/

People using ancient non-NAPI kernels better upgrade to 2.4.20.
If they really, really, really cannot upgrade (and this only
happens when they are stuck with binary module crap), they
should say "I will quit this tob tomorrow" three times,
then use RH AS2.1 driver, only make sure to get tg3 1.2e3
from drivers/addon/tg3 in 2.4.9-e.12.

-- Pete
