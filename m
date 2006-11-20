Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756721AbWKTLYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721AbWKTLYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756725AbWKTLYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:24:43 -0500
Received: from kuu212123311.barco.com ([212.123.3.11]:10115 "HELO
	kuuvir01.barco.com") by vger.kernel.org with SMTP id S1756721AbWKTLYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:24:42 -0500
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
References: <200611201200.36780.ml@stefan-roese.de>
X-message-flag: Sleipner uptime: 6 days,  3:13, 28 users
Date: Mon, 20 Nov 2006 12:24:36 +0100
In-Reply-To: <200611201200.36780.ml@stefan-roese.de> (Stefan Roese's message
	of "Mon, 20 Nov 2006 12:00:36 +0100")
Message-ID: <87odr2mkcr.fsf@sleipner.barco.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Stefan" == Stefan Roese <ml@stefan-roese.de> writes:

Hi,

Stefan> This patch fixes a problem seen on multiple 4xx platforms,
Stefan> where the UART0 interrupt number is 0. The macro
Stefan> "is_real_interrupt" lead on those systems to not use an real
Stefan> interrupt but the timer based implementation.

That's not the proper way to fix this. Instead remap the interrupt
number to make 0 invalid.

I sent a similar patch some months ago and that was the reply I got:

http://marc.theaimsgroup.com/?t=114363521500003&r=1&w=2

-- 
Bye, Peter Korsgaard
