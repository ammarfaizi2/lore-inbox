Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272327AbRHXVMi>; Fri, 24 Aug 2001 17:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272329AbRHXVM2>; Fri, 24 Aug 2001 17:12:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56837 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272327AbRHXVMN>; Fri, 24 Aug 2001 17:12:13 -0400
Subject: Re: Is it bad to have lots of sleeping tasks?
To: hzhong@cisco.com (Hua Zhong)
Date: Fri, 24 Aug 2001 22:15:21 +0100 (BST)
Cc: ddade@digitalstatecraft.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <005a01c12cd9$2f153950$103147ab@cisco.com> from "Hua Zhong" at Aug 24, 2001 01:13:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15aOIT-0006Xa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So why not do it?  Or implement a nicer scheduler?  There are many good
> ones.  There are o(1) schedulers that provide much better proportional
> sharing.  They scale and also perform well even in "few running processes"
> case.  They are also not hard to implement (I once implemented such a
> scheduler with 100 lines of patch, and that fitted in the existing Linux
> runqueue framework).  What's the resistence to scheduler changes?

The resistance I've seen has been to schedulers that perform more poorly
with < 3 running processes - that being the normal case.

Its also suprisingly hard to find a very simple scheduler that provides
fairness and cache optimal behaviour while working well SMP. Uniprocessor
is easy, uniprocessor with real time isnt too bad, SMP gets tricky.

I'd definitely like to see a better scheduler in the kernel, providing its
as fast for the < 3 processes case too.

Alan
