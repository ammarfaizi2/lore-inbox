Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278222AbRJSAF5>; Thu, 18 Oct 2001 20:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278226AbRJSAFh>; Thu, 18 Oct 2001 20:05:37 -0400
Received: from smtp1.legato.com ([137.69.200.1]:36071 "EHLO smtp1.legato.com")
	by vger.kernel.org with ESMTP id <S278222AbRJSAFb>;
	Thu, 18 Oct 2001 20:05:31 -0400
Message-ID: <016a01c15831$ef51c5c0$5c044589@legato.com>
From: "David E. Weekly" <dweekly@legato.com>
To: "ML-linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Date: Thu, 18 Oct 2001 17:06:43 -0700
Organization: Legato Systems, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I was trying to speed up kernel compiles experimentally by moving the source
tree into tmpfs and compiling there. It seemed to work okay and crunched
through the dep phase and most of the main build phase just fine, but then
it hit a file, got an internal segfault, and stopped. I tried again -- this
time make itself segfaulted. Three more times of make segfaulting -- a
strace on make didn't reveal what was failing. Then strace started
segfaulting. Eventually "ls" segfaulted and the machine needed to be
manually rebooted. Ouch!

I ran the full memtest86 suite on the machine, and it passed with flying
colors. So the memory proper is okay.

I come to one of two conclusions: this is a wierd problem with my north
bridge, or there's something funky going on with tmpfs.

Is tmpfs stable?

Yours,
 -david


