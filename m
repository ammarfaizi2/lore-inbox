Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271606AbTGXPPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 11:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271685AbTGXPPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 11:15:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53711 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S271606AbTGXPPX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 11:15:23 -0400
Date: Thu, 24 Jul 2003 10:30:07 -0500
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: David McCullough <davidm@snapgear.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1059046125.7993.11.camel@dhcp22.swansea.linux.org.uk>
Message-Id: <B45078B7-BDEB-11D7-B453-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, Jul 24, 2003, at 06:28 US/Central, Alan Cox wrote:
>
> Code size for critical paths is getting more and more performance 
> critical
> on x86 as well as on the embedded CPU systems. 3Ghz superscalar 
> processors
> lose a lot of clocks to a memory stall.

So you're arguing for more inlining, because icache speculative 
prefetch will pick up the inlined code?

Or you're arguing for less, because code like get_current() which is 
called frequently could have a single copy living in icache?

-- 
Hollis Blanchard
IBM Linux Technology Center

