Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287828AbSBOML3>; Fri, 15 Feb 2002 07:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287770AbSBOMLU>; Fri, 15 Feb 2002 07:11:20 -0500
Received: from [66.150.46.254] ([66.150.46.254]:46893 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S287828AbSBOMLO>;
	Fri, 15 Feb 2002 07:11:14 -0500
Message-ID: <3C6CFADD.EE84E954@wgate.com>
Date: Fri, 15 Feb 2002 07:11:09 -0500
From: Michael Sinz <msinz@wgate.com>
Organization: WorldGate Communications Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; FreeBSD 4.5-STABLE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Core dump file control
In-Reply-To: <3C6BE18F.7B849129@wgate.com> <20020215124036.C23673@unthought.net> <3C6CF4AA.8040808@evision-ventures.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Jakob Østergaard wrote:
> 
> >On Thu, Feb 14, 2002 at 11:10:55AM -0500, Michael Sinz wrote:
> >
> >>I have, for a long time, wished that Linux had a way to specify where
> >>core dumps are stored and what the name of the core dump is.  Now that
> >>I have been building large linux clusters with many diskless nodes,
> >>this need has become even more important.
> >>
> >...
> >
> >I just wanted to throw in my 0.02 Euro on this one:
> >
> >I have not yet tested your patch yet - but this functionality is *very*
> >important to my company as well.
> >
> >Anyone developing applications with multiple processes will benefit
> >significantly from having core files named differnetly than just "core".
> >
> >A patch was included in the kernel some time ago, to allow the appending of the
> >PID - however, this is not really good enough. It's better than nothing, but
> >it's not good.
> >
> >What I want is "core.[process name]" eventually with a ".[pid]" appended.  A
> >flexible scheme like your patch implements is very nice.   Actually having
> >the core files in CWD is fine for me - I mainly care about the file name.
> 
> Please execute the size command on the core fiel:
> 
> size core
> 
> to see why this isn't needed.

Huh?  explain...  If I have multiple programs running and one cores, 
would I not want to have the core file name be based on the program that
cored?  Linux had the PID option (kernel.core_uses_pid) specifically so
that you could have multiple process core files.

Plus, I need to be able to redirect core files to a sane location in the
cluster (which is a whole other kettle of fish).

-- 
Michael Sinz ---- Worldgate Communications ---- msinz@wgate.com
A master's secrets are only as good as
	the master's ability to explain them to others.
