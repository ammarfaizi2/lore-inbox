Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSLaMJ4>; Tue, 31 Dec 2002 07:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSLaMJ4>; Tue, 31 Dec 2002 07:09:56 -0500
Received: from 214pc221.sshunet.nl ([131.211.221.214]:19716 "EHLO chili")
	by vger.kernel.org with ESMTP id <S261686AbSLaMJx>;
	Tue, 31 Dec 2002 07:09:53 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre2 IDE problems
From: Marijn Ros <marijn@mad.scientist.com>
Date: 31 Dec 2002 13:18:15 +0100
Message-ID: <87isxa4c1k.fsf@214pc221.sshunet.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

My (old, but still newest) machine has a UM8886A south bridge with IDE
controller. This chip is not supported and therefor runs at PIO mode
0, yielding a whopping 2MB/s throughput with the normal (old) 2.4 IDE
code.

However, when I try the new 2.4.21-pre2 taskfile IO setting, I get a
'hda: lost interrupt' message every 30 seconds (the timeout period I
guess) during disk IO, making the machine unusable. I know this
setting is experimental, but I guess you would like to know about my
problems before the old code is phased out completely.

I understood that taskfile IO is a backport of 2.5 code, so I decided
to try 2.5.53 too. Strangely, it doesn't loose IDE interrupts, but
seems to loose clock interrupts during disk IO, as ntpd looses sync
(0.6-1.2s per 20 minutes) during a kernel compile but not during
normal usage (web-browsing and e-mail on an otherwise idle
system). Setting kernel preemtion doesn't make a difference (don't
know why I decided to test that anymore).

I am not on this list, but plan to read the archives avery day. If
more information is needed, please CC me so I can send a proper reply.

Bye,
        Marijn
