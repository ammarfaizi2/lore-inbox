Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSLLNb3>; Thu, 12 Dec 2002 08:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbSLLNb3>; Thu, 12 Dec 2002 08:31:29 -0500
Received: from mta11n.bluewin.ch ([195.186.1.211]:58191 "EHLO
	mta11n.bluewin.ch") by vger.kernel.org with ESMTP
	id <S264646AbSLLNb2>; Thu, 12 Dec 2002 08:31:28 -0500
Date: Thu, 12 Dec 2002 14:39:03 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Alan Cox <alan@ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: i8253 count too high! resetting..
Message-ID: <20021212133903.GB3224@k3.hellgate.ch>
Mail-Followup-To: Alan Cox <alan@ukuu.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.21-pre1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting my sys log filled with "i8253 count too high! resetting.." in
2.4.21-pre1.

The same happened in 2.2.19 with the kernel suggesting the culprit was a
VIA686a -- which it wasn't, the chipset's ALi. The trigger differs only
so slightly: 2.2.19 tests for
count > LATCH-1
whereas 2.4.21-pre1 checks
count > LATCH

The rate is high enough to be quite annoying -- here's a syslog snippet:

Dec 12 14:02:33 k3 kernel: i8253 count too high! resetting..
Dec 12 14:05:23 k3 kernel: i8253 count too high! resetting..
Dec 12 14:05:51 k3 kernel: i8253 count too high! resetting..
Dec 12 14:06:29 k3 kernel: i8253 count too high! resetting..
Dec 12 14:07:30 k3 kernel: i8253 count too high! resetting..

FWIW the board (an Asus A7A266) has worked reasonably well for over a year
and I hadn't gotten the impression so far that the timer needs fixing
desperately.

Roger
