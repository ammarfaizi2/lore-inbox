Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVLWBL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVLWBL3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 20:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVLWBL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 20:11:29 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:3264 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751229AbVLWBL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 20:11:28 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 4k stacks
Date: Fri, 23 Dec 2005 12:11:20 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <pfjmq1dtcrq5hos687h0gm9nrg79v3ceat@4ax.com>
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005 16:53:25 -0500, "linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:

>
>
>Yesterday I sent a patch to add stack-poison so the stack usage
>could be observed.
>
>Today I wrote a small program and tested the stack usage. Both
>the program and the patch is attached. The result is:
>
>Offset : 2ec8f000	Available Stack bytes = 3104
>Offset : 2ecb1000	Available Stack bytes = 3104
>Offset : 2ee5f000	Available Stack bytes = 20

Hmm:
# ./stack
Offset : 003fb000       Available Stack bytes = 3348
Offset : 0195d000       Available Stack bytes = 3620
Offset : 01961000       Available Stack bytes = 3828
Offset : 01963000       Available Stack bytes = 3088
Offset : 01b7d000       Available Stack bytes = 2952
Offset : 01b9f000       Available Stack bytes = 2616
Offset : 3753d000       Available Stack bytes = 3628
Offset : 3755d000       Available Stack bytes = 3604
Offset : 3755f000       Available Stack bytes = 3608
Offset : 37561000       Available Stack bytes = 3608
Offset : 37563000       Available Stack bytes = 3608
Offset : 37585000       Available Stack bytes = 3608
Offset : 37655000       Available Stack bytes = 3756
Offset : 37657000       Available Stack bytes = 3592
Offset : 37659000       Available Stack bytes = 3304
Offset : 37753000       Available Stack bytes = 3608
Offset : 37755000       Available Stack bytes = 3756
Offset : 377b3000       Available Stack bytes = 3880
Offset : 378e5000       Available Stack bytes = 3648
Offset : 37977000       Available Stack bytes = 3608
Offset : 37979000       Available Stack bytes = 3604
Offset : 3799d000       Available Stack bytes = 3820
Offset : 37c07000       Available Stack bytes = 3376
Offset : 37c27000       Available Stack bytes = 3652
Offset : 37dcf000       Available Stack bytes = 2580
Offset : 37def000       Available Stack bytes = 3556
Offset : 37df1000       Available Stack bytes = 3732
Offset : 37f13000       Available Stack bytes = 3612
Offset : 37f15000       Available Stack bytes = 3604
Offset : 37f35000       Available Stack bytes = 3608

I get the crash on startup when 4k + 4k is set too :(

http://bugsplatter.mine.nu/test/boxen/sempro/ with 8k 2.6.14.4.

Grant.
