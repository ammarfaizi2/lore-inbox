Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVKWVVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVKWVVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVKWVVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:21:13 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:65484 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932458AbVKWVVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:21:13 -0500
Subject: Re: Sub jiffy delay?
From: Steven Rostedt <rostedt@goodmis.org>
To: Rick Niles <niles@rickniles.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200511232039.PAA03184@bellona.cnchost.com>
References: <200511232039.PAA03184@bellona.cnchost.com>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 16:20:42 -0500
Message-Id: <1132780842.6694.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 15:39 -0500, Rick Niles wrote:
> I need to service a piece of hardware about every 400-500
> microseconds, but I really don't want to change the value of HZ, which
> in my version of the 2.6 kernel is 1000.  The hardware doesn't have an
> interrupt so the nasty hack I've been doing is to service the hardware
> repeatedly in a loop for about 600 microseconds by watching the
> do_gettimeofday(), set a timer for the next jiffy and repeat.  This leaves less than 400 microseconds / millisecond for the kernel and anything else on the system to run.
> 
> Obviously, this sucks, but it does work. I am working with the
> hardware guy to add an interrupt to the hardware.  However, I don't
> want every user of the hardware without the interrupt to have to
> rebuild the kernel with a different value of HZ.  So does anyone have
> any better ideas on what I can do?

Have you looked at Thomas Gleixner's ktimer/HRT patches.  It gives you a
way to set a timer to go off within a jiffy.

http://tglx.de/ktimers.html

-- Steve


