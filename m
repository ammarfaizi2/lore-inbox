Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUFGVNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUFGVNA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUFGVNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:13:00 -0400
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:48787 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265060AbUFGVM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:12:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Date: Tue, 8 Jun 2004 07:12:44 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
References: <20040607195735.46697.qmail@web51801.mail.yahoo.com>
In-Reply-To: <20040607195735.46697.qmail@web51801.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406080712.44759.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2004 05:57, Phy Prabab wrote:
> I have had a chance to test this patch.  

Thanks

> I have a make 
> system that has presented 2.6 kernels with problems,
> so  I am using this as the test.  Observations show
> that turning off interactive is much more
> deterministic:
>
> 2.6.7-rc2-bk8-s63:
> echo 0 > /proc/sys/kernel/interactive
>
> A:  35.57user 38.18system 1:20.28elapsed 91%CPU
> B:  35.54user 38.40system 1:19.48elapsed 93%CPU
> C:  35.48user 38.28system 1:20.94elapsed 91%CPU
>
> 2.6.7-rc2-bk8-s63:
> A:  35.32user 38.51system 1:26.47elapsed 85%CPU
> B:  35.43user 38.35system 1:20.79elapsed 91%CPU
> C:  35.61user 38.23system 1:25.00elapsed 86%CPU
>
> However, something is still slower than the 2.4.x
> kernels:
>
> 2.4.23:
> A:  28.32user 29.51system 1:01.17elapsed 93%CPU
> B:  28.54user 29.40system 1:01.48elapsed 92%CPU
> B:  28.23user 28.80system 1:00.21elapsed 94%CPU
>
> Nice work, as I can now turn off some functionality
> within the kernel that is causing me some slow down.

Glad to see it does what you require. Turning off "interactive" should still 
provide moderately good interactive performance at low to moderate loads, but 
is much stricter about cpu usage distribution as you can see.

Cheers,
Con
