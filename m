Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261470AbSIWXqs>; Mon, 23 Sep 2002 19:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbSIWXqs>; Mon, 23 Sep 2002 19:46:48 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:25759 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S261470AbSIWXqr>; Mon, 23 Sep 2002 19:46:47 -0400
Date: Mon, 23 Sep 2002 19:55:58 -0400
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hint benchmark reaches memory size limit on 4gb box
Message-ID: <20020923235558.GA28954@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Should the bench be adjusted, or should I boot 2.5.36-mm1?

> Both, sorry.

Lorenzo did an update to qsbench.  qsbench is much faster 
than hint for a ram shortage simulation.

Current lineup:
qsbench with 2 process = 120% TotalMem

1) qsbench alone
2) qsbench with ed compile loop
3) qsbench + very small chat bench loop (5 clients, 1 room)
4) qsbench + postmark loop with ~ 40000 small files

Hm, guess i should also time 2, 3, and 4 without qsbench 
for comparison.  2, 3, 4 run in less than 10 seconds 
on quad xeon.  The idea is to count the loops that complete 
during the time for qsbench to do it's thing.

The first run on 2.5.38 got overwritten during a mkfs. :(

Any suggestions before i lose the next batch of data ;)

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

