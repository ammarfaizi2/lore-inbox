Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVBQPJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVBQPJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVBQPJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:09:24 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:55229 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261408AbVBQPE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:04:28 -0500
Date: Thu, 17 Feb 2005 16:04:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050217150455.GA1723@ucw.cz>
References: <20050211201013.GA6937@ucw.cz> <1108457880.2843.5.camel@localhost> <20050215134308.GE7250@ucw.cz> <1108578892.2994.2.camel@localhost> <20050216213508.GD3001@ucw.cz> <1108649993.2994.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108649993.2994.18.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 03:19:53PM +0100, Kenan Esau wrote:

> > Would you be so kind to post the 'dmesg' log?
> 
> Shure -- here you are...
> 
> ...
> input: LBPS/2 Fujitsu Lifebook TouchScreen on isa0060/serio1
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [78488524]
> drivers/input/serio/i8042.c: f5 -> i8042 (parameter) [78488524]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78488532]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [78488753]
> drivers/input/serio/i8042.c: ff -> i8042 (parameter) [78488753]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78488759]
> drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux, 12) [78488822]
> drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [78488823]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489004]
> drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [78489004]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78489009]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489009]
> drivers/input/serio/i8042.c: 07 -> i8042 (parameter) [78489009]
> drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12) [78489014]

Ok, this is a regular 'I don't know what you mean' response from the
pad.

> drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489014]
> drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [78489014]
> drivers/input/serio/i8042.c: fc <- i8042 (interrupt, aux, 12) [78489018]

But this return code is _very_ unusual. 0xfc means 'basic assurance test
failure' and should be reported only as a response to the 0xff command.

> drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489216]
> drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [78489216]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78489218]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489219]
> drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [78489219]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78489223]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489223]
> drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [78489223]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78489228]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489229]
> drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [78489229]
> drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78489233]

Nothing else important here.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
