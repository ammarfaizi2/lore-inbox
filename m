Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264988AbRFUOj3>; Thu, 21 Jun 2001 10:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbRFUOjT>; Thu, 21 Jun 2001 10:39:19 -0400
Received: from ivy.tec.in.us ([168.91.1.1]:48256 "EHLO Otter.ivy.tec.in.us")
	by vger.kernel.org with ESMTP id <S264988AbRFUOjI>;
	Thu, 21 Jun 2001 10:39:08 -0400
From: John Madden <jmadden@ivy.tec.in.us>
Organization: Ivy Tech State College
To: Masaru Kawashima <masaru@scji.toshiba-eng.co.jp>,
        Dionysius Wilson Almeida <dwilson@technolunatic.com>
Subject: Re: eepro100: wait_for_cmd_done timeout
Date: Thu, 21 Jun 2001 09:37:47 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010620163134.A22173@technolunatic.com> <20010621231939.757bddd6.masaru@scji.toshiba-eng.co.jp>
In-Reply-To: <20010621231939.757bddd6.masaru@scji.toshiba-eng.co.jp>
MIME-Version: 1.0
Message-Id: <0106210940470C.28098@ycn013>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dionysius Wilson Almeida <Dionysius Wilson Almeida <dwilson@technolunatic.com>> wrote:
> > Jun 20 16:14:07 debianlap kernel: eepro100: wait_for_cmd_done timeout!
> > Jun 20 16:14:38 debianlap last message repeated 5 times
> 
> I saw the same message.
> 
> The comment before wait_for_cmd_done() function in
> linux/drivers/net/eepro100.c says:
> /* How to wait for the command unit to accept a command.
>    Typically this takes 0 ticks. */
> 
> And the initial value for the bogus counter, named "wait", is 1000.
> Is it enough for your machine?
> 
> I applied attached patch, eepro100.patch.  After that, I've never seen
> the message from wait_for_cmd_done().  And, my NIC works fine.
> 
> You may want to adjust the initial value for the bogus counter.
> I don't know the appropriate value for this bogus counter.

int wait is set to 20000 in my eepro100.c (stock 2.2.19), and I still get these
errors.  Think the patch with the udelay() will still work?

John




-- 
John Madden
UNIX Systems Engineer
Ivy Tech State College
jmadden@ivy.tec.in.us
