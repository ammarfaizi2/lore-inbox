Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272370AbSISStc>; Thu, 19 Sep 2002 14:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272400AbSISStb>; Thu, 19 Sep 2002 14:49:31 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:15367 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S272370AbSISSt2>; Thu, 19 Sep 2002 14:49:28 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
Date: Thu, 19 Sep 2002 18:54:06 +0000 (UTC)
Organization: Cistron
Message-ID: <amd6ge$fng$3@ncc1701.cistron.net>
References: <20020919163542.GA14951@win.tue.nl> <Pine.LNX.4.44.0209190938340.1594-100000@home.transmeta.com>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1032461646 16112 62.216.29.67 (19 Sep 2002 18:54:06 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0209190938340.1594-100000@home.transmeta.com>,
Linus Torvalds  <torvalds@transmeta.com> wrote:
>
>On Thu, 19 Sep 2002, Andries Brouwer wrote:
>> The controlling terminal is inherited by a child process during a fork()
>> function call. A process relinquishes its controlling terminal when it creates
>> a new session with the setsid() function; other processes remaining in the
>> old session that had this terminal as their controlling terminal continue
>> to have it.
>
>Well, that certainly clinches the fact that the controlling terminal _can_ 
>and does continue to be hold by processes outside the current session 
>group.

No, not at all. A few lines above that it said:

>> A terminal that is associated with a session. Each session may have
>> at most one controlling terminal associated with it, and a controlling
>> terminal is associated with exactly one session.

A session has zero or 1 controlling terminals. A controlling
terminal is associated with one session only.

Mike.

