Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVAKU6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVAKU6B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVAKU6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:58:00 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:13715
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262050AbVAKU5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:57:50 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ilias Biris <xyz.biris@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4e1a70d10501111246391176b@mail.gmail.com>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <1105461106.16168.41.camel@localhost.localdomain>
	 <4e1a70d1050111111614670f32@mail.gmail.com>
	 <4e1a70d10501111246391176b@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 21:57:49 +0100
Message-Id: <1105477069.17853.126.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 16:46 -0400, Ilias Biris wrote:
> well looking into Alan's email again I think I answered thinking on
> the wrong side :-) that the suggestion was to switch off OOM
> altogether and be done with all the discussion... tsk tsk tsk too
> defensive and hasty I guess :-)
> 
> Thinking it in another way alan's email could have the dimension of
> switching off overcommitment (and thus OOM) whilst in the user-space
> ranking stage to avoid reentrancy and invocation of oom again and
> again before killing something. It also solves the issue of using
> timed/counted resources  which is plain ugly and evil. It would though
> be necessary to switch OOM back on when the OOMK has finally done the
> kill.
>
> Did I get it right this time Alan? 

I don't get it at all.

Fixes for wrong invocation, reentrancy avoidance, removal of the ugly
and evil timer,counter hacks are in the wild since more than 6 weeks.
They solve the problem without any userspace interaction. 

The userspace provided preferrable victim list is an improvement of the
generic heuristic and therefor imperfect selection mechanism and nothing
else.

tglx


