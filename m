Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287307AbSACOu0>; Thu, 3 Jan 2002 09:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287319AbSACOuQ>; Thu, 3 Jan 2002 09:50:16 -0500
Received: from gherkin.frus.com ([192.158.254.49]:2176 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S287307AbSACOuG>;
	Thu, 3 Jan 2002 09:50:06 -0500
Message-Id: <m16M9Bl-0005kjC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: weird application breakage in 2.5.2-pre5
To: linux-kernel@vger.kernel.org
Date: Thu, 3 Jan 2002 08:49:49 -0600 (CST)
CC: axboe@kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The application is elm2.4.ME+.82 with PGP 6.5.8.  Works fine under
kernel version 2.4.17.  Under 2.5.2-pre5, when I try to encrypt+sign
a message to a particular recipient for which I have two matching keys
on my pgp keyring, no matching pgp key is found.  The *only* difference
between "works" and "doesn't" is the kernel version.

Cranked up the debug level on elm in an attempt to see what's happening,
and at level 41, I notice that the parent (elm) isn't reading anything
from the child (pgp -kv recipient_address).  No error indication of any
kind, so fork(), pipe(), execl(), fdopen(), and fgets() all seem to be
happy.

libc version is 2.2.3.

Possible side-effect of bio changes?

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
