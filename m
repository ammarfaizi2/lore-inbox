Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266535AbUFQPoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUFQPoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUFQPoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:44:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:51087 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266535AbUFQPn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:43:58 -0400
Date: Thu, 17 Jun 2004 08:41:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: bmarsh@bmarsh.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use of Moxa serial card with SMP kernels
Message-Id: <20040617084132.510d0bcb.rddunlap@osdl.org>
In-Reply-To: <200406171112.39485.bmarsh@bmarsh.com>
References: <200406171112.39485.bmarsh@bmarsh.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 11:12:39 -0400 Bruce Marshall wrote:

| Moxa serial card option not available when requesting an SMP kernel  (2.6.7)
| 
| I was told back when 2.6.4 was new that the selection of a Moxa serial card 
| was not possible if an SMP kernel was selected.  I used the work-around of 
| not using an SMP kernel.
| 
| My question:   Is this a permanent problem which will never be fixed or a 
| temporary situation?

It's permanent until someone takes the time and trouble to fix it.

Both Moxa serial drivers (moxa & mxser) are BROKEN_ON_SMP because
they use cli() to disable interrupts for critical sections.
See Documentation/cli-sti-removal.txt for details.
They will need some acceptable modern form of protection there,

Is anyone working on this?  not that I've heard of.
Have you tried this email address:
Copyright (C) 1999-2000  Moxa Technologies (support@moxa.com.tw).

Is anyone out there motivated to fix this?  This is Bruce's real
question, I believe.

--
~Randy
