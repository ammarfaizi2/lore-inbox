Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSFES1F>; Wed, 5 Jun 2002 14:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315993AbSFES1F>; Wed, 5 Jun 2002 14:27:05 -0400
Received: from dsl-213-023-039-098.arcor-ip.net ([213.23.39.98]:47810 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315988AbSFES1D>;
	Wed, 5 Jun 2002 14:27:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mark Mielke <mark@mark.mielke.cc>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 20:26:14 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206050957250.2614-100000@waste.org> <E17Feeo-0001bQ-00@starship> <20020605140637.A23183@mark.mielke.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17FfU7-0001dP-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 20:06, Mark Mielke wrote:
> On Wed, Jun 05, 2002 at 07:32:34PM +0200, Daniel Phillips wrote:
> > On Wednesday 05 June 2002 17:37, Oliver Xymoron wrote:
> > > No, the mistake is assuming that loosely coupling UNIX to RT lets you
> > > leverage much of anything from UNIX.
> >    - Compiler
> >    - Debugger
> >    - Editor
> >    - GUI
> >    - IPC
> >    - Any program that doesn't require realtime response
> >    - Memory protection
> >    - Physical hardware can be shared
> >    - I could go on...
> 
> So... an RT .mp3 player task that receives asynchronous signals from a
> non-RT .mp3 player GUI front-end? So, we assume that the .mp3 data
> gets sent from the non-RT file system to the RT task (via the non-RT
> GUI front-end) in its entirety before it begins playing...
> 
> Other than as a play RT project, seems like a waste of effort to me... :-)

Your opinion is noted, however it's also noted that you didn't support it in
any way.

Also, it appears you didn't read the post you responded to.  Two alternatives
were presented:

  1) Load the whole mp3 into memory before playing it
  2) Implement a filesystem with realtime response

Both approaches have their uses.  The second is the one I'm interested in,
if that isn't already obvious.  The first is just a quick hack that will
give you guaranteed-skipless audio playback, something that Linux is
currently unable to do.

> The result will be that your compiler/debugger/editor/etc. will have limited
> access to the CPU, and will therefore likely run slower. (The rest of the
> processes effectively run as "idle tasks")

No no no.  The compiler/debugger run under the general purpose OS, and only
a stub of the debugger runs on the RTOS.

-- 
Daniel
