Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSEULmr>; Tue, 21 May 2002 07:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313083AbSEULmq>; Tue, 21 May 2002 07:42:46 -0400
Received: from otitsun.oulu.fi ([130.231.48.144]:8434 "EHLO otitsun.oulu.fi")
	by vger.kernel.org with ESMTP id <S312998AbSEULmp>;
	Tue, 21 May 2002 07:42:45 -0400
Date: Tue, 21 May 2002 14:42:44 +0300
From: Antti Salmela <asalmela@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: ext3 assertion failure and oops, 2.4.18
Message-ID: <20020521114244.GA29043@otitsun.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can reliably reproduce an assertion failure and oops in ext3 by simply
restarting cyrus21, if directories used by cyrus have +j flag set with
chattr. Filesystem was mounted with default journalling mode data=orderded,
kernels tested were 2.4.18 and 2.4.19-pre3-ac4. Recent -pre or -ac kernels
wouldn't compile with my .config.

Assertion failure in journal_revoke() at revoke.c:330:
"!(__builtin_constant_p(BH_Revoked) ? constant_test_bit((BH_Revoked),(
&bh->b_state)) : variable_test_bit((BH_Revoked),( &bh->b_state)))"

I'll capture whole oops if requested.

I found two similar cases from lkml archives, but they were left
unresponded (atleast lkml wasn't cc'ed). I couldn't judge from changelogs if
this problem has been already fixed.

http://groups.google.com/groups?selm=2446DD7E.7F1AEC90.00A5E169%40netscape.net&output=gplain
http://groups.google.com/groups?as_umsgid=%3C2446DD7E.7F1AEC90.00A5E169%40netscape.net%3E&lr=&hl=en

-- 
Antti Salmela
