Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272072AbRIJWbd>; Mon, 10 Sep 2001 18:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272074AbRIJWbX>; Mon, 10 Sep 2001 18:31:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27407 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272072AbRIJWbN>; Mon, 10 Sep 2001 18:31:13 -0400
Date: Mon, 10 Sep 2001 15:26:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <Pine.LNX.4.33.0109101439261.1034-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0109101522590.1034-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Btw, with IDE disks, you might try to enable the drive lookahead by hand -
whether it is enabled by default or not may depend on the drive. Try if
"hdparm -A1 /dev/hdX" makes a difference for you.

(It probably doesn't, simply because it's probably already enabled, and
even if it isn't, the lookahead buffer isn't likely to be big enough to
help that much with the fundamental seeking problem in doing a recursive
diff).

		Linus

