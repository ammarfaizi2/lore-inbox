Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSGQSxs>; Wed, 17 Jul 2002 14:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSGQSxr>; Wed, 17 Jul 2002 14:53:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62471 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316465AbSGQSxr>; Wed, 17 Jul 2002 14:53:47 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Date: 17 Jul 2002 18:51:25 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <ah4ebd$2vc$1@gatekeeper.tmr.com>
References: <1026490866.5316.41.camel@thud> <20020716122756.GD4576@merlin.emma.line.org> <20020716124331.GJ7955@tahoe.alcove-fr> <20020716125301.GI4576@merlin.emma.line.org>
X-Trace: gatekeeper.tmr.com 1026931885 3052 192.168.12.62 (17 Jul 2002 18:51:25 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020716125301.GI4576@merlin.emma.line.org>,
Matthias Andree  <matthias.andree@stud.uni-dortmund.de> wrote:

| dsmc fstat()s the file it is currently reading regularly and retries the
| dump as the changes, and gives up if it is updated too often. Not sure
| about the server side, and certainly not a useful option for sequential
| devices that you directly write on. Looks like a cache for the biggest
| file is necessary.

Which doesn't address the issue of data in files A, B and C, with
indices in X and Y. This only works if you flush and freeze all the
files at one time, making a perfect backup of one at a time results in
corruption if the database is busy.

My favorite example is usenet news on INN, a bunch of circular spools, a
linear history with two index files, 30-40k overview files, and all of
it changing with perhaps 3.5MB/sec data and 20-50/sec index writes. Far
better done with an application backup!

The point is, backups are hard, for many systems dump is optimal because
it's fast. After that I like cpio (-Hcrc) but that's personal
preference. All have fail cases on volatile data.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
