Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWABEqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWABEqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 23:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWABEqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 23:46:37 -0500
Received: from mail.gmx.de ([213.165.64.21]:49049 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932322AbWABEqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 23:46:36 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060102052345.00be97c8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 02 Jan 2006 05:46:29 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.15-rc7-rt1] explosions in nptl mutex tests
Cc: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5.2.1.1.2.20051231180437.00be1b20@pop.gmx.net>
References: <5.2.1.1.2.20051231171108.00bd9f40@pop.gmx.net>
 <1136044188.6039.102.camel@localhost.localdomain>
 <5.2.1.1.2.20051231152916.00bd5fd0@pop.gmx.net>
 <5.2.1.1.2.20051231152916.00bd5fd0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0550-0, 12/10/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:10 PM 12/31/2005 +0100, Mike Galbraith wrote:
>At 05:36 PM 12/31/2005 +0100, Mike Galbraith wrote:
>
>>As luck would have it, just as I was collecting the data, there was a 
>>major explosion.  Box was slogging through glibc make check, and when it 
>>hit the mutex tests in nptl, KaBOOM.  Ding-dong-dead box... [reboot] oh 
>>my, seems repeatable.  Guess I'll see if I can find my serial console 
>>cable instead of typing make install as originally planned :)
>>
>>         -Mike
>
>Oopsen attached.  First two times it exploded on tst-mutex7, this time 
>that passed, but it exploded on tst-mutex7a.

Further datapoint: on a lark, I tried 8k stacks, and my symptoms changed - 
tst-mutex7 never failed, but running tst-mutex7a in a tight loop crashed 
the box reliably though differently.  I then recompiled with no debug 
options enabled, and ran all mutex tests in a loop for a couple of hours 
with no crash.

         -Mike 

