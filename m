Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbTLRP2V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 10:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbTLRP2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 10:28:21 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:48280 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265207AbTLRP2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 10:28:20 -0500
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: Joe Pranevich <jpranevich@kniggit.net>
Subject: Re: Wonderful World of Linux 2.6 - Final
Date: Thu, 18 Dec 2003 09:29:46 -0600
User-Agent: KMail/1.5
References: <1071724386.2820.12.camel@localhost.localdomain>
In-Reply-To: <1071724386.2820.12.camel@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312180929.46723.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 December 2003 23:13, Joe Pranevich wrote:
> Hello,
>
> I haven't even seen the email yet from linux-kernel about the v2.6
> release, but if Slashdot says it's so, it *must* be true. I have just
> put the finishing touches on my document describing many of the changes
> in the new kernel release. If you're interested, please check it out. It
> should be pretty accurate.
>
> Check it out:
>
> HTML - http://kniggit.net/wwol26.html
> TEXT - http://kniggit.net/wwol26.txt

Hyperthreading:

"...that the scheduler now knows how to recognize and optimize processor loads 
across both real and virtual processors within a machine."


This is not true.  Ingo's shared runqueue patch did not make it into 2.6, nor 
did Nick's scheduler domain patch.  Workloads with low loads and HT will not 
be scheduled optimally, for example, a kernel compile with -j4 on a 4-way P4, 
with and without HT:

average of 10 kernel compiles with -j4 on 2.6.0-test9:

HT disabled: Elapsed: 145.086s User: 513.808s System: 44.724s CPU: 384.5%
HT enabled: Elapsed: 172.463s User: 633.856s System: 48.003s CPU: 394.8%


-Andrew Theurer

