Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280059AbRK1TNS>; Wed, 28 Nov 2001 14:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRK1TNJ>; Wed, 28 Nov 2001 14:13:09 -0500
Received: from mail.science.uva.nl ([146.50.4.51]:31168 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S280059AbRK1TMu>; Wed, 28 Nov 2001 14:12:50 -0500
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Date: Wed, 28 Nov 2001 20:11:59 +0100 (MET)
From: Kamil Iskra <kamil@science.uva.nl>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with APM suspend and ext3
In-Reply-To: <3C03CEFB.780622F1@zip.com.au>
Message-ID: <Pine.SOL.4.30.0111282007440.26732-100000@carol.wins.uva.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Andrew Morton wrote:

> I don't understand what can be causing the behaviour which you
> report.  Presumably, some application is generating disk writes,
> and kjournald is thus performing disk IO every five seconds.

The only such "application" could be syslogd or apmd.  There is virtually
nothing more running in single user mode.

> If possible, could you please edit fs/jbd/journal.c and change
>
>       journal->j_commit_interval = (HZ * 5);
> to
>       journal->j_commit_interval = (HZ * 30);

Just tried it.  Unfortunately, it didn't improve anything.  Consistent
failure what doing "apm -s".  I tried some 15 times or so in single user
mode.

Should you, or anybody else, have further suggestions, I'll be happy to
try them out.

-- 
Kamil Iskra                 http://www.science.uva.nl/~kamil/
Section Computational Science, Faculty of Science, Universiteit van Amsterdam
kamil@science.uva.nl  tel. +31 20 525 75 35  fax. +31 20 525 74 90
Kruislaan 403  room F.202  1098 SJ Amsterdam  The Netherlands

