Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293089AbSCXNbX>; Sun, 24 Mar 2002 08:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293109AbSCXNbO>; Sun, 24 Mar 2002 08:31:14 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:775 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293089AbSCXNbD>;
	Sun, 24 Mar 2002 08:31:03 -0500
Date: Sun, 24 Mar 2002 10:30:32 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: andreas <andihartmann@freenet.de>
Cc: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <3C9DC1F5.6010508@athlon.maya.org>
Message-ID: <Pine.LNX.4.44L.0203241029000.18660-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, andreas wrote:

> I've got a basic question:
> Would it be possible to kill only the process which consumes the most
> memory in the last delta t?

> rsync is an actual example for the problem, I wrote. This could be any
> other process, eating up the memory. Then, the kernel kills wildly some
> processes until the right process is killed - and the machine is
> probably unavailable meanwhile.

The problem is that 'rsync' might as well have been 'scientific
calculation that ran for 3 days'.

One 'solution' could be to let the OOM killer ignore CPU usage
of less than say 1 hour, but it'll always be heuristics that
can go wrong in some scenario.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

