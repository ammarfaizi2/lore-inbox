Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTBXUUe>; Mon, 24 Feb 2003 15:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267427AbTBXUUe>; Mon, 24 Feb 2003 15:20:34 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:11533 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267425AbTBXUUd>; Mon, 24 Feb 2003 15:20:33 -0500
Date: Mon, 24 Feb 2003 20:30:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: george@mvista.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.63
Message-ID: <20030224203046.A14425@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, george@mvista.com,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Feb 24, 2003 at 11:32:07AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> George Anzinger <george@mvista.com>:
>   o POSIX clocks & timers

Care to explain what  FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
is supposed to do?  It's always defined in signal.h, so we can
aswell get rid of it..

And what's this:

#ifndef div_long_long_rem
+#include <asm/div64.h>
+
+#define div_long_long_rem(dividend,divisor,remainder) ({ \
+                      u64 result = dividend;           \
+                      *remainder = do_div(result,divisor); \
+                      result; })
+
+#endif                         /* ifndef div_long_long_rem */

Any reason you can't just use do_div directly like everyone else? :)


