Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280673AbRKBMqV>; Fri, 2 Nov 2001 07:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280670AbRKBMqM>; Fri, 2 Nov 2001 07:46:12 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:48646 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S280668AbRKBMqC>; Fri, 2 Nov 2001 07:46:02 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Fri, 2 Nov 2001 12:46:01 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9ru4i9$e47$1@ncc1701.cistron.net>
In-Reply-To: <20011102124252.1032e9b2.rusty@rustcorp.com.au> <Pine.GSO.4.21.0111020359540.12621-100000@weyl.math.psu.edu>
X-Trace: ncc1701.cistron.net 1004705161 14471 195.64.65.67 (2 Nov 2001 12:46:01 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0111020359540.12621-100000@weyl.math.psu.edu>,
Alexander Viro  <viro@math.psu.edu> wrote:
>On Fri, 2 Nov 2001, Rusty Russell wrote:
>
>> On Thu, 01 Nov 2001 05:42:36 -0500
>> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>> 
>> > Is this designed to replace sysctl?
>> 
>> Well, I'd suggest replacing *all* the non-process stuff in /proc.  Yes.
>
>Aha.  Like, say it, /proc/kcore.  Or /proc/mounts, yodda, yodda.

Well in 2.5 union mounts are going to go in right? Then you could
have a compatibility "proc-compat" filesystem that reads data from
/kernel and supplies it in backwards compatible formats such as
/proc/mounts, that you union-mount over /proc

And in 2.7, rm -rf linux/fs/proc-compat

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

