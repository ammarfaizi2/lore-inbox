Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEAJL>; Thu, 4 Jan 2001 19:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRAEAJB>; Thu, 4 Jan 2001 19:09:01 -0500
Received: from 13dyn200.delft.casema.net ([212.64.76.200]:30220 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129183AbRAEAIy>; Thu, 4 Jan 2001 19:08:54 -0500
Message-Id: <200101050008.BAA14222@cave.bitwizard.nl>
Subject: Network oddity.... 
To: linux-kernel@vger.kernel.org
Date: Fri, 5 Jan 2001 01:08:49 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all, 

I have a server, and it reports ("netstat -a")

tcp        0      0 server:ssh    client:1022 SYN_RECV

This sounds normal right?

However there are 79 of these lines in the netstat output. Not normal!

A TCP connection is identified by the 12 bytes source IP, dest IP,
source port, dest port. Right? Then as far as I can see, these should
all refer to the SAME socket. (yes, they all refer to server:ssh, and
client: 1022!)

Oh, this situation seems to continue: it sends a syn-ack and then the
client replies with a reset. This goes on and on. I'm going to make
the client disappear, and hope that this makes the number of these
connections go away.

Kernel is 2.2.13. That was "fresh" when the system was booted. Yes,
that's over 14 months ago. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
