Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUCaUSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 15:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbUCaUSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 15:18:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3973 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262443AbUCaUSo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 15:18:44 -0500
Date: Wed, 31 Mar 2004 15:13:31 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: davidm@hpl.hp.com
cc: Alex Williamson <alex.williamson@hp.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       ulrich.windl@rz.uni-regensburg.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 on Itanium2: floating-point assist fault at ip
 400000000062ada1, isr 0000020000000008
In-Reply-To: <16491.6076.504437.267920@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.53.0403311504590.12643@chaos>
References: <406AE0D5.10359.1930261@localhost> <200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua>
 <16491.2184.253165.545651@napali.hpl.hp.com> <1080757433.2326.32.camel@patsy.fc.hp.com>
 <Pine.LNX.4.53.0403311339550.12319@chaos> <16491.6076.504437.267920@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, David Mosberger wrote:

> >>>>> On Wed, 31 Mar 2004 13:53:13 -0500 (EST), "Richard B. Johnson" <root@chaos.analogic.com> said:
>
>   Richard> The power-on or hardware-reset default for the ix86 FPU
>   Richard> is to attempt to handle div 0 errors transparently.
>
> I must be missing something.  So far I haven't seen anything that
> would suggest the FPSWA faults were due to infinities.  I'd guess that
> it's much more likely that they're due to denormals.
>
> 	--david


ftp://download.intel.com/design/Itanium/Downloads/24541401.pfd

	"Itanium Processor Floating-point Software Assistance
	and Floating-Point Exception Handling"


Any FPU fault gets trapped to this code. Nans, Denormals, Overflow,
Inexact, etc., everything....

The reading of 2.2 may not be clear, but further reading will
show that anything that didn't go according to plan gets trapped
to the "Software Assistance" Handler. Writing a message about
the trap to a log-file is a BUG! The handler should just do
whatever it's supposed to do!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


