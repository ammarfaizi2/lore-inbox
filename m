Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbRGEJns>; Thu, 5 Jul 2001 05:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbRGEJni>; Thu, 5 Jul 2001 05:43:38 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:61700 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S262568AbRGEJn2>; Thu, 5 Jul 2001 05:43:28 -0400
Date: Thu, 5 Jul 2001 13:43:06 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: alpha - generic_init_pit - why using RTC for calibration?
Message-ID: <20010705134306.A2071@jurassic.park.msu.ru>
In-Reply-To: <022901c10095$f4fca650$4d28d0c3@jscc.ru> <20010629211931.A582@jurassic.park.msu.ru> <20010704114530.A1030@twiddle.net> <003e01c10522$1c9cf580$4d28d0c3@jscc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <003e01c10522$1c9cf580$4d28d0c3@jscc.ru>; from vdovikin@jscc.ru on Thu, Jul 05, 2001 at 11:14:19AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 11:14:19AM +0400, Oleg I. Vdovikin wrote:
>     Richard, thanks. But please use calibrate_cc version which I've submited
> as a patch - it gives more accuracy with maximum latch we can ever use and

With both variants even on a 166MHz CPU you'll get above 1e-7 precision,
which is way above accuracy of any crystal oscillator.

> has cc's type changed to 'unsigned int' to prevent problems when rpcc
> overflows.

The only difference is that you'll have extra 'zap' instruction converting
'unsigned int' to 'unsigned long'.

Ivan.
