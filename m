Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270675AbTGUTu7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270674AbTGUTu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:50:59 -0400
Received: from tuubi175.adsl.netsonic.fi ([194.29.196.175]:33673 "HELO
	home.killeri.net") by vger.kernel.org with SMTP id S270675AbTGUTu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:50:58 -0400
To: linux-kernel@vger.kernel.org
Subject: Unable to suspend (S4) with the latest 2.5/2.6 kernels
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: Kalle Kivimaa <killer@iki.fi>
Organization: MikaVaan School of Flying
X-Home-Page: http://killeri.net
Date: Mon, 21 Jul 2003 23:05:39 +0300
Message-ID: <8765lvmyr0.fsf@home.killeri.net>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.5 (broccoli, linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere along the 2.5.7x series I lost the ability to swsuspend my
Compaq Evo N1020v laptop. From the logs and the headers it seems that
the suspend code requires pse feature on the machine. The
/proc/cpuinfo reports that my machine has psu36 support but not psu
and the code in include/asm-i386/suspend.h only tests for psu support.
Is this a bug or a feature? I was able to suspend and resume about 90%
of the time with the 2.5.69 kernel.

I even tried to change the cpufeatures.h in 2.5.75 so that it would
test for the presense of psu36 support but that crashed the kernel
right at the startup...

Please CC me on the replies as I'm not on the list (I do read it
through the archives so I will see your responses even if you forget
to).

-- 
*              Dean's Rule #45. The truth hurts for a moment.             *
*                       A lie hurts for a long time.                      *
*           PGP public key available @ http://www.iki.fi/killer           *
