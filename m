Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSFESMt>; Wed, 5 Jun 2002 14:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSFESMs>; Wed, 5 Jun 2002 14:12:48 -0400
Received: from mark.mielke.cc ([216.209.85.42]:57096 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S315760AbSFESMr>;
	Wed, 5 Jun 2002 14:12:47 -0400
Date: Wed, 5 Jun 2002 14:06:37 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Message-ID: <20020605140637.A23183@mark.mielke.cc>
In-Reply-To: <Pine.LNX.4.44.0206050957250.2614-100000@waste.org> <E17Feeo-0001bQ-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 07:32:34PM +0200, Daniel Phillips wrote:
> On Wednesday 05 June 2002 17:37, Oliver Xymoron wrote:
> > No, the mistake is assuming that loosely coupling UNIX to RT lets you
> > leverage much of anything from UNIX.
>    - Compiler
>    - Debugger
>    - Editor
>    - GUI
>    - IPC
>    - Any program that doesn't require realtime response
>    - Memory protection
>    - Physical hardware can be shared
>    - I could go on...

So... an RT .mp3 player task that receives asynchronous signals from a
non-RT .mp3 player GUI front-end? So, we assume that the .mp3 data
gets sent from the non-RT file system to the RT task (via the non-RT
GUI front-end) in its entirety before it begins playing...

Other than as a play RT project, seems like a waste of effort to me... :-)

The result will be that your compiler/debugger/editor/etc. will have limited
access to the CPU, and will therefore likely run slower. (The rest of the
processes effectively run as "idle tasks")

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

