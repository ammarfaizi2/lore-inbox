Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271995AbRHVNEj>; Wed, 22 Aug 2001 09:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271996AbRHVNEU>; Wed, 22 Aug 2001 09:04:20 -0400
Received: from web10901.mail.yahoo.com ([216.136.131.37]:49925 "HELO
	web10901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271995AbRHVNEN>; Wed, 22 Aug 2001 09:04:13 -0400
Message-ID: <20010822130428.77456.qmail@web10901.mail.yahoo.com>
Date: Wed, 22 Aug 2001 06:04:28 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: brlock_is_locked()?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1771960962-998485468=:76457"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1771960962-998485468=:76457
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Everyone,

	Is there a politically correct way to determine if a brlock
is in the locked or unlocked state, i.e. with something like this:

restart:
	if (brlock_is_locked(BR_NETPROTO_LOCK)) {
		CRITICAL_SECTION
		br_write_unlock_bh(BR_NETPROTO_LOCK);
	}
	else {
		/* Let's get dizzy */
		br_write_lock_bh(BR_NETPROTO_LOCK);
		goto restart;
	}

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net

Reply to the address I used in the message to you,
please!

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
--0-1771960962-998485468=:76457--
