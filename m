Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268333AbRHAVk2>; Wed, 1 Aug 2001 17:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268347AbRHAVkS>; Wed, 1 Aug 2001 17:40:18 -0400
Received: from 209-221-203-158.dsl.qnet.com ([209.221.203.158]:13573 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S268333AbRHAVkM>; Wed, 1 Aug 2001 17:40:12 -0400
Message-ID: <3B68771C.615A0C73@rinspin.com>
Date: Wed, 01 Aug 2001 14:39:40 -0700
From: Scott Bronson <bronson@rinspin.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk,
        Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: AMD/VIA: v4l and adi conflict update
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last week I described the conflict between v4l and the adi module
I was seeing.  Since then, Oliver Neukum and I have traced it to the
K7 optimizations--if I optimize the stock 2.4.7 kernel for PII, the
problem goes away.  This is 100% reproducible.

Can this provide any insight into the ongoing VIA problems?  If
anyone has anything they'd like me to test (Alan?), please tell me.

I'm running a VIA Apollo KX133-based motherboard (700 MHz Athlon on
an Epox EP-7KXA).  The problem that I am tracking, real briefly, is if
if I use v4l (either a bttv-based TV tuner or a webcam) before using
the joystick after I boot the computer, the joystick fails to respond.
However, if I use the joystick first, then everything works as it should.

	- Scott


For completeness:
In a different converstaion, Oliver Neukum wrote:
>changing the compiler is unlikely to work, as most K7 optimisations are 
>assembly.
>
>However these problems are probably related to VIA chipsets. Your symptoms 
>are new. There is a chance that a report to the kernel mailing list and Alan 
>Cox might be valuable to those developing a workaround.
>
>There is a good chance that there's a bug in the DMA handling in the VIA 
>chipsets. It might be triggered by the picture transfers.
>Please report this.
