Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTAOVbG>; Wed, 15 Jan 2003 16:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbTAOVbG>; Wed, 15 Jan 2003 16:31:06 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:61923 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267310AbTAOVbF> convert rfc822-to-8bit; Wed, 15 Jan 2003 16:31:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Andreas Schwab <schwab@suse.de>, Jakob Oestergaard <jakob@unthought.net>
Subject: Re: Changing argv[0] under Linux.
Date: Wed, 15 Jan 2003 15:36:31 -0600
User-Agent: KMail/1.4.1
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <20030115164731.GB8621@unthought.net> <jeel7ehzon.fsf@sykes.suse.de>
In-Reply-To: <jeel7ehzon.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301151536.31653.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 January 2003 03:26 pm, Andreas Schwab wrote:
> Jakob Oestergaard <jakob@unthought.net> writes:
> |> Can anyone point out a problem in the above? I'd be happy to see it shot
> |> down, mainly because it's ugly - and I hate programs that mess with
> |> argv[0].
>
> argv[0] is not required to point to the actual file name of the
> executable, and in fact, most of the time it won't.

And don't count on it for portability - Some systems take a copy of arg0 for
the process tables, and changing it will NOT alter the process name. It is
only the default action for shell programs. All others can make arg0 anything
they want  - as login effectively does ..

	execl ("pathtoshell", "-", 0)

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
