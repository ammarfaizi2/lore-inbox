Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWDJRGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWDJRGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWDJRGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:06:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:47837 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751096AbWDJRGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:06:02 -0400
X-Authenticated: #13409387
Message-ID: <443A8D70.3040906@gmx.net>
Date: Mon, 10 Apr 2006 18:53:04 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] Buggy uart (for 2.6.16)
References: <1144676225.12145.30.camel@localhost.localdomain>
In-Reply-To: <1144676225.12145.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>Ingo,
>
>I've noticed that you dropped my "buggy uart" patch.  Probably because
>the 2.6.14 version would cause a deadlock on 2.6.16.  I've sent you a
>new update, but it must have been lost in all the noise.  Here's the
>patch again.  If you don't think this is a bug, try running the attached
>program on the machine that deadlocked (it is the one with the buggy
>uart). Without the patch, the serial_test will miss a wake up, and then
>be stuck in the sleeping TASK_INTERRUPTIBLE state (at least you can
>still kill it).  With the patch, it runs fine.
>
>I ran the program with the following parameters:
>
># ./serial_test /dev/ttyS0 115200 8 0 0 4
>
>(Disclaimer: I did not write this serial_test.  It was hacked up by my
>customer to show me that this bug exists).
>
>This may also be a bug with the vanilla kernel, since I don't see why it
>is not. I'll run more tests on the vanilla kernel, and if it too misses
>a wake up, I'll submit this to vanilla as well.
>
>
>Some 8250 uarts don't zero out the NO_INTERRUPT bit of the IIR register
>  
>
Can you name the exact 8250 model which is buggy ?

