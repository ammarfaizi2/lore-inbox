Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132176AbQLQWVh>; Sun, 17 Dec 2000 17:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132313AbQLQWV2>; Sun, 17 Dec 2000 17:21:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22289 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132176AbQLQWVY>; Sun, 17 Dec 2000 17:21:24 -0500
Date: Sun, 17 Dec 2000 22:50:57 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: /dev/random: really secure?
Message-ID: <20001217225057.A8897@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed peculiarities in the behaviour of the delta-delta-3 system for
entropy estimation in the random.c code./ When I hold right alt or control, I
get about 8 bits of entropy per repeat fro the /dev/random which is
overestimated. I think the real entropy is 0 bits because it is absolutely
deterministic when the interrupt comes. Am I right or is there any hidden
magic source of entropy in this case?

Right shift, left alt, ctrl and shift make 4 bits per repeat. Is greater
randomness being expected from the keys that return 8 bits?

When I have a server where n blobk read, keyboard and mouse events occur
(everything is cached within huge amount of semiconductor RAM), the /dev/random
depends solely on the network packets. These can be manipulated and their
leading edge precisely sniffed. I think here exists a severe risk of
compromise. Am I right?

Clock
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
