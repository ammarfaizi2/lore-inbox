Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVLYWLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVLYWLM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 17:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVLYWLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 17:11:12 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:60571 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750953AbVLYWLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 17:11:12 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: tglx@linutronix.de
Subject: Re: [PATCH/RFC 10/10] example of simple continuous gettimeofday
Date: Sun, 25 Dec 2005 17:50:27 +0100
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0512220028250.30930@scrub.home> <1135247382.2806.122.camel@tglx.tec.linutronix.de>
In-Reply-To: <1135247382.2806.122.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512251750.31440.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thomas, Ingo, I would really appreciate if you didn't pick up on some small 
detail in my mail and draw final conclusions from it for the whole 
discussion, before you even have seen the final result. I really thought I 
made it clear, that this patch is more a proof-of-concept patch, which make 
your comments rather pointless, especially since you leave the central parts 
of the mail uncommented, you didn't even have a single question about it. 
This either tells me you understood what I wrote, but it's beneath you to 
comment on it or you didn't understand it and you just want me to shut up. 
Either way I have a hard time not to take it personal.

On Thursday 22 December 2005 11:29, Thomas Gleixner wrote:

> Can we please concentrate on a clear and generic design model before
> discussing optimizations of 20 lines of code?

Fine with and that's exactly what the rest of the mail was about.

On Thursday 22 December 2005 10:01, Ingo Molnar wrote:

> Also, lets face it: with the union ktime_t type most of the '64-bit is
> slow on 32-bit' issues are much less of a problem. If some 32-bit arch
> wants to pull off its own timekeeping system, it can do so - but
> otherwise we want to move towards generic, unified (as far as it makes
> sense) and generally 64-bit-optimized subsystems. In 1995 i'd have
> agreed with Roman, but not in 2005.

ktime_t doesn't magically solve all problems, it just hides them better.
The main point of my mail is to provide a theoretical base of a good 
gettimeofday implementation, which would allow a generic _and_ fast 
implementation. Why do you insist on 64bit, if I can actually prove it's only 
a waste of time?

bye, Roman

