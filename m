Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271961AbRIIOFd>; Sun, 9 Sep 2001 10:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271962AbRIIOFN>; Sun, 9 Sep 2001 10:05:13 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:21134 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S271961AbRIIOE7>;
	Sun, 9 Sep 2001 10:04:59 -0400
Date: Sun, 9 Sep 2001 16:03:56 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Lockup with 2.4.9-ac9
Message-ID: <Pine.LNX.4.21.0109091547090.8049-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I upgraded a server from 2.4.4-ac10 to 2.4.9-ac9 two days ago and I've
been having problems with it since then (reverted to the old but working
2.4.4-ac10 for now).

Description of machine:

Celeron 366 with 256MB ram.
two IDE-drives in a striped Logical Volume.
Reiserfs ontop of that LV.

(it also acts as a "smb-hub", redistributing quite a few smb-shares, but
this doesn't seem to be the source of the lockup)

The machine simply locks up and doesn't say a word, no Oops or
anything, looks like a deadlock. 
This happened 4 times yesterday and every time there was one user that was
uploading a lot of data (a few GB) in quite high speeds to this LV.

So it seems like it locks up during writes to this reiserfs ontop of the
LV. 

The machine doesn't have a keyboard but maybe sysrq works if I plug one
in...

Any clues to what might be going on?
Anything I should be monitoring until it deadlocks?
Or any patch I should try backing out?

/Martin

