Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318186AbSG3BQi>; Mon, 29 Jul 2002 21:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318189AbSG3BQi>; Mon, 29 Jul 2002 21:16:38 -0400
Received: from sm13.texas.rr.com ([24.93.35.40]:54921 "EHLO sm13.texas.rr.com")
	by vger.kernel.org with ESMTP id <S318186AbSG3BQh>;
	Mon, 29 Jul 2002 21:16:37 -0400
Subject: Re: 2.5.29: bug in ide and hd kernel option handling
From: Gerald Champagne <gerald@io.com>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Jul 2002 20:19:53 -0500
Message-Id: <1027991999.15188.17.camel@wiley>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, that would most likely be my fault.  I made some small changes to
the parameter parsing code recently.

> On my 486 test box (ISA/VLB only, CONFIG_PCI=n), passing any
> any ide or hd kernel option (like idebus=33) to 2.5.29 results
> in a kernel hang at boot: I get the initial "Uncompressing ..
> booting .." and then nothing.

The no display symptom makes sense if there's a problem in a setup
routine.  These routines are called before console_init.  Printk's
before console_init are queued up and only displayed after console_init
is called.  If the kernel hangs before this point, nothing is displayed.

> With 2.5.27, the kernel instantly rebooted itself instead.

The changes went in in 2.5.27.

Can you please send my your .config file?  I'll look at this tonight.

Thanks.

Gerald




