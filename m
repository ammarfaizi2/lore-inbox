Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTIRWGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 18:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTIRWGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 18:06:22 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:46529 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S262174AbTIRWGV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 18:06:21 -0400
Date: Fri, 19 Sep 2003 00:06:17 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: Patch: Make iBook1 work again
In-Reply-To: <1063916627.603.5.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309182225430.6680-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Sep 2003, Benjamin Herrenschmidt wrote:

>
> > The Mach64 LT does not have the M64F_FIFO_24 flag set! That will result in
> > completely different values to be calculated and cause a distorted
> > display.
>
> I confirm, problem fixed ;)

Great! I'm a bit puzzled how it could work before; it might be
accidentally or the old code was tweaked and tweaked till the timings
seemed to work, but at the cost of working in the generic case. It might
explain why the code deviated so much from the formulas in the
documentation.

It also makes me think of the 63 MHz clock speed, as you did indicate it
should be 67 MHz. Knowing that the memory clock speed is used in the display
fifo calculation, I wonder if it was tweaked to get things right.

Enough speculation, I'll post a patch asap, but I have currently no Linux
machines around me. Expect a patch tomorrow.

Greetings,

Daniël Mantione

