Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVKWUjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVKWUjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVKWUjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:39:24 -0500
Received: from bellona.cnchost.com ([207.155.248.226]:11174 "EHLO
	bellona.cnchost.com") by vger.kernel.org with ESMTP id S932401AbVKWUjW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:39:22 -0500
Message-ID: <200511232039.PAA03184@bellona.cnchost.com>
From: Rick Niles <niles@rickniles.com>
To: <linux-kernel@vger.kernel.org>
Reply-To: Rick Niles <niles@rickniles.com>
Subject: Sub jiffy delay?
Date: Wed, 23 Nov 2005 15:39:17 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to service a piece of hardware about every 400-500
microseconds, but I really don't want to change the value of HZ, which
in my version of the 2.6 kernel is 1000.  The hardware doesn't have an
interrupt so the nasty hack I've been doing is to service the hardware
repeatedly in a loop for about 600 microseconds by watching the
do_gettimeofday(), set a timer for the next jiffy and repeat.  This leaves less than 400 microseconds / millisecond for the kernel and anything else on the system to run.

Obviously, this sucks, but it does work. I am working with the
hardware guy to add an interrupt to the hardware.  However, I don't
want every user of the hardware without the interrupt to have to
rebuild the kernel with a different value of HZ.  So does anyone have
any better ideas on what I can do?

Thanks,
Rick Niles.
