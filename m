Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbUJYObz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbUJYObz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUJYOby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:31:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13955 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261836AbUJYO3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:29:24 -0400
Date: Mon, 25 Oct 2004 16:30:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Uncompressing Linux... Out of memory: fixed by increased HEAP_SIZE
Message-ID: <20041025143014.GA14992@elte.hu>
References: <200410251628.20505.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410251628.20505.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> booting newest 2.6.9 experimental kernels, I frequently encountered 
> "Uncompressing Linux... Out of memory --System halted"
> In some mail archive I found the (obvious ;-) solution: Increase HEAP_SIZE.
> 
> Here in line 122 of arch/i386/boot/compressed/misc.c this
> 	#define HEAP_SIZE             0x4000
> instead of 
> 	#define HEAP_SIZE             0x3000
> made 2.6.9-mm1-RT-U10.3 boot again.

ah! Makes sense. Did you have LATENCY_TRACE enabled? That compiles the
kernel with -pg which creates a fatter stackframe.

	Ingo
