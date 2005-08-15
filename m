Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVHOVP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVHOVP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbVHOVP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:15:56 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:38810 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S964920AbVHOVPz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:15:55 -0400
Date: Mon, 15 Aug 2005 23:15:52 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Jim Ramsay <jim.ramsay@gmail.com>
cc: yhlu <yhlu.kernel@gmail.com>, James Simmons <jsimmons@infradead.org>,
       <alex.kern@gmx.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atyfb questions and issues
In-Reply-To: <4789af9e050815135169a76799@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0508152313460.11750-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Op Mon, 15 Aug 2005, schreef Jim Ramsay:

> On 8/15/05, yhlu <yhlu.kernel@gmail.com> wrote:
> > last year some time, I have manually the patch from 2.4 to 2.6. my
> > patch result is the same as 2.4. It only works when bios doesn't do
> > the init. Then if the BIOS do the init, it will hang there. I assume
> > something only can be done once.
>
> That is exactly what I did in my proposed patch, attached earlier.
>
> I noticed the same problem.
>
> Does anyone out there know how you can tell if the RageXL chip has
> already been initialized?
>
> One test I have that works on my hardware is to test the STAT0
> register.  If it ends with 0x95, the chip has not been initialized,
> otherwise I initialize it.

Perhaps you can check if the oscillators are enabled. If the chip is being
clocked for DLLCLK and that kind of clocks, the internal clock synthesizer
is most likely not yet programmed to generate usefull clock signals and I
would expect its oscillator to be switched off.

Daniël

