Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268444AbRGXURA>; Tue, 24 Jul 2001 16:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268445AbRGXUQu>; Tue, 24 Jul 2001 16:16:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48430 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S268444AbRGXUQh>; Tue, 24 Jul 2001 16:16:37 -0400
To: Barry Wu <wqb123@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about serial console problem
In-Reply-To: <20010723065212.31153.qmail@web13901.mail.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Jul 2001 14:10:44 -0600
In-Reply-To: <20010723065212.31153.qmail@web13901.mail.yahoo.com>
Message-ID: <m17kwyhyuz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Barry Wu <wqb123@yahoo.com> writes:

> Hi, all,
> 
> I am porting linux 2.4.3 to our mipsel evaluation
> board. Now I meet a problem. Because I use edown
> to download the linux kernel to evaluation board.
> I update the serial baud rate to 115200.
> I use serial 0 as our console, and I can use
> printk to print debug messages on serial port.
> But after kernel call /sbin/init, I can not
> see "INIT ...  ..." messages on serial port.
> I suppose perhaps I make some mistakes. But when
> I use 2.2.12 kernel, it ok.
> If someone knows, please help me. Thanks!

It's a bug in init.  INIT clears the CREAD flag which means all reads
to the console will be dropped.  Why it /sbin/init works before 2.4.3
is a mystery.

Eric

