Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282938AbRK0Uos>; Tue, 27 Nov 2001 15:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282941AbRK0Uoj>; Tue, 27 Nov 2001 15:44:39 -0500
Received: from zero.tech9.net ([209.61.188.187]:59657 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282938AbRK0UoZ>;
	Tue, 27 Nov 2001 15:44:25 -0500
Subject: Re: [PATCH] proc-based cpu affinity user interface
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111271247120.9992-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0111271247120.9992-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 27 Nov 2001 15:44:53 -0500
Message-Id: <1006893895.815.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-27 at 06:52, Ingo Molnar wrote:
> two comments. First, this has already been done - Andrew Morton has
> written such a patch.

I didn't know this until after I started, but it is irrelevant.  Use
Andrew's if you want.  However, I have incorporated some useful bits
from your patch and such that I think are superior.

> Second, as i've repeatedly said it, it's a failure to do this over /proc.
> What if /proc is not mounted? What if the process is in a chroot()
> environment, should it not be able to set its own affinity? This is a
> fundamental limitation of your approach, and *if* we want to export the
> cpus_allowed affinity to user-space (which is up to discussion), then the
> right way (TM) to do it is via a syscall.

OK OK OK ... we can argue all day over syscall vs. proc.  Personally, I
don't find any of the arguments fruitful -- we make all sorts of
restrictions and "Don't do thats" in the kernel.  Requiring procfs isn't
the end of the world.

When you posted your initial patch, I commented I liked it but was
interested in a proc variant.  Some people were interested.  Even you
said it wasn't a huge deal.

It doesn't matter to me, let's just expose _some_ interface to
userspace.  Personally, I prefer procfs, but both implementations are
nicely done.  I respect you too much to argue religion like this.  I'll
push for either variant.

	Robert Love

