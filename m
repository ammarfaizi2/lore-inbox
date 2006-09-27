Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWI0Nbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWI0Nbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 09:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWI0Nbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 09:31:47 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:58334 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751187AbWI0Nbr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 09:31:47 -0400
Date: Wed, 27 Sep 2006 15:31:44 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] at91_serial: Introduction
Message-ID: <20060927153144.47871208@cad-250-152.norway.atmel.com>
In-Reply-To: <1159261584.24659.16.camel@fuzzie.sanpeople.com>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	<20060923211417.GB4363@flint.arm.linux.org.uk>
	<1159261584.24659.16.camel@fuzzie.sanpeople.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Sep 2006 11:06:24 +0200
Andrew Victor <andrew@sanpeople.com> wrote:

> Patch 2 & 3 look correct, but they would need to be tested.

Ok, I've tested part 2 (at91_serial: Fix roundoff error in
at91_console_get_options), and it works on my AT91RM9200-EK board. In
fact, the latest git code does _not_ work -- I see the same garbage as
on ATSTK1000, and this patch fixes it.

Part 3 probably has real problems, and I'm not sure how to fix it. I'll
try some kind of "break timeout" so that any problems will at least be
transient. The current break code works on neither STK1000 nor
AT91RM9200-EK, so even a not-quite-100%-correct fix should be
acceptable, no?

I'm queuing up some patches now that I'll send off as soon as I get them
tested on both ARM and AVR32. This includes the big rename patch I've
been talking about.

Håvard
