Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312376AbSCUPu0>; Thu, 21 Mar 2002 10:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312380AbSCUPuQ>; Thu, 21 Mar 2002 10:50:16 -0500
Received: from gherkin.frus.com ([192.158.254.49]:384 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S312376AbSCUPuM>;
	Thu, 21 Mar 2002 10:50:12 -0500
Message-Id: <m16o4pO-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.7: acct.c oops
To: linux-kernel@vger.kernel.org
Date: Thu, 21 Mar 2002 09:50:10 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I might have missed this one.  After all, this is a pretty low-traffic
list :-).

Running "accton" (with or without arguments) consistently generates
an oops at linux/kernel/acct.c:169
	BUG_ON(!spin_is_locked(&acct_globals.lock));

I first saw this when shutting down my machine.  The shutdown scripts
run "accton" without any arguments to terminate accounting, regardless
of whether it's running.

2.5.7 kernel on a Dell laptop running a Mandrake distribution.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
