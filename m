Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751966AbWCKJvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbWCKJvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 04:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbWCKJvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 04:51:16 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:52459 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751966AbWCKJvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 04:51:15 -0500
Date: Sat, 11 Mar 2006 10:51:13 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MCE Errors, Bad CPU, Memory or Motherboard?
Message-ID: <20060311095113.GA32274@fiberbit.xs4all.nl>
References: <Pine.LNX.4.64.0603100642220.1165@p34>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603100642220.1165@p34>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 10th 2006 Justin Piszcz wrote:

> This is the first time I have seen an MCE error, googling the EIP value at 
> the time of the panic does not return any useful results.
> 
> Does anyone know whether it is the CPU or MEMORY that is bad in this 
> machine?  As it shows some problems with BANK4; however, if the CPU is 
> bad, then it is possible to get all sorts of unpredictable results, right?

If it's the memory you can try swapping RAM sticks or taking them out
altogether, if you have more than one.

Recently I saw these kind of MCE events also happen on a 3 year old
Athlon 2000 machine, which was on 24/7. There it finally turned out that
I ran an "athcool" program which enables powersaving mode on idle state.
Although this saves energy and reduces the fan noise, switching back to
work mode apparently wasn't fast enough anymore after these years. After
disabling the powersaving the MCE errors were gone.

The difference between these MCE's on memory or on the ACPI powersaving
(if you use that at all) is really simple to diagnose: for memory they
will occur on a very busy system, whereas the powersaving errors will
occur on a completely idle system.

But you might have real hardware problems of course. Then use the usual
routines: memtest(86), check the cooling, power surges, etc.
-- 
Marco Roeland
