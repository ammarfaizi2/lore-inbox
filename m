Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263807AbUEXBrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUEXBrv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 21:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUEXBrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 21:47:51 -0400
Received: from lakermmtao11.cox.net ([68.230.240.28]:22963 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S263807AbUEXBrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 21:47:49 -0400
Message-ID: <32786.192.168.0.243.1085363267.squirrel@webmail.rtwsecurenet.com>
In-Reply-To: <20040522172724.6c804068.akpm@osdl.org>
References: <32847.192.168.0.243.1085236590.squirrel@webmail.rtwsecurenet.com>
    <20040522172724.6c804068.akpm@osdl.org>
Date: Sun, 23 May 2004 20:47:47 -0500 (CDT)
Subject: Re: 2.6 high CPU utilization with multimedia apps {Scanned}
From: rettw@rtwnetwork.com
To: "Andrew Morton" <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
X-rtwnetwork.com-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> This could be an artifact from the instrumentation - if
> the application is
> doing short bursts of work the 1000Hz clock may be
> providing more accurate
> sampling.
>
> In 2.6, edit include/asm/param.h and set HZ to 100 and
> then redo the
> measurement.
>
That did it - the CPU utilization is back down to what I
am used to seeing on 2.4. - Now, the question is - what
was more accurate?  Was 2.4 producing abnormally low
numbers?  Or 2.6 abnormally high?  One interesting thing,
just below the define statements in the file mentioned
above is a conditional define that sets HZ to 100 anyway,
if not already defined - it almost seems that the 1000
value is bogus to begin with.

Thanks again for the help - this has been quite a mystery....

Thanks,

Rett Walters

