Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUHJNXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUHJNXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUHJNUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:20:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39574 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265214AbUHJNPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:15:22 -0400
Date: Tue, 10 Aug 2004 15:16:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>, V13 <v13@priest.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810131628.GA28167@elte.hu>
References: <200408091217.50786.jbarnes@engr.sgi.com> <20040810100234.GN11200@holomorphy.com> <20040810115307.GR11200@holomorphy.com> <200408101552.22501.v13@priest.com> <20040810125140.GU11200@holomorphy.com> <20040810125529.GA22650@elte.hu> <20040810125651.GV11200@holomorphy.com> <20040810130122.GA26326@elte.hu> <20040810141220.B20890@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810141220.B20890@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Except serial console IO does not generate _any_ IRQ traffic - it
> purposely disables IRQs on the device before starting any IO to
> prevent any user-level IO interfering with the console output.

indeed - but it does generate _some_ IRQ traffic still:

  3:        251    IO-APIC-edge  serial

this is from a box that uses the serial line only for the kernel
console.

	Ingo
