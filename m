Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279619AbRJXWT7>; Wed, 24 Oct 2001 18:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279620AbRJXWTw>; Wed, 24 Oct 2001 18:19:52 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:23843 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S279619AbRJXWTf>; Wed, 24 Oct 2001 18:19:35 -0400
Date: Thu, 25 Oct 2001 08:28:22 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19: fs corrupt after freeze-on-wakeup
Message-ID: <Pine.LNX.4.05.10110250748500.4202-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Nasty problem: filesystem corruption (ugly, reports of blocks duplicated
between files that are > 6months old, etc, etc).

Background: this is an AcerNote-950C, which exhibits "oddities" in the APM
department.  Last night the battery expired <sigh> but after reconnecting
power and waking it up I was presented with the message:

"probable hardware bug: clock timer configuration lost - probably a VIA686a."
"probable hardware bug: restoring chip configuration."

(from arch/i386/kernel/time.c) and a hard lockup.

(1) how would I confirm if I have a "VIA686a" (not mentioned in dmesg)?  
FWIW, the CPU is a Pentium (as in NOT a -II etc).

This lockup-on-wakeup has occured before (but not every time with 2.2.19,
and without nasty consequences (till today)).

Presumably the "VIA686a test code" in arch/i386/kernel/time.c doesn't
agree with my system:

(2) Is there anything I can do to qualify this?

(3) Lastly, is there likely to be a connection between the VIA686a issues
and the filesystem corruption, or is this corruption likely to just be a
consequence of the unclean shutdown etc?

Thanks,
Neale.

