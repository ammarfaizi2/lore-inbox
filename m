Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129513AbRBFO34>; Tue, 6 Feb 2001 09:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129512AbRBFO3g>; Tue, 6 Feb 2001 09:29:36 -0500
Received: from linuxcare.com.au ([203.29.91.49]:47884 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129517AbRBFO31>; Tue, 6 Feb 2001 09:29:27 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 7 Feb 2001 01:28:45 +1100
To: christophe barbe <christophe.barbe@inup.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ and sleep_on
Message-ID: <20010207012844.C15995@linuxcare.com>
In-Reply-To: <20010205131154.I31876@pc8.inup.com> <20010205133837.A485@pc8.inup.com> <3A7EA3B0.2D7CFA19@colorfullife.com> <20010205175348.A2372@pc8.inup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010205175348.A2372@pc8.inup.com>; from christophe.barbe@inup.com on Mon, Feb 05, 2001 at 05:53:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm very interesting to know why it's bad to restore flags in a sub-function.
> I imagine it should be due to an optimisation in the restore function.

On sparc32 the flags includes the window pointer which tells us where in
the register windows we are. If you restore flags in a sub function
the kernel will become very confused :)

Forcing cli/sti etc to be in the same function also helps readability.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
