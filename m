Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287860AbSBOMNj>; Fri, 15 Feb 2002 07:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288158AbSBOMN3>; Fri, 15 Feb 2002 07:13:29 -0500
Received: from unthought.net ([212.97.129.24]:54491 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S287860AbSBOMNW>;
	Fri, 15 Feb 2002 07:13:22 -0500
Date: Fri, 15 Feb 2002 13:13:20 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Michael Sinz <msinz@wgate.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Core dump file control
Message-ID: <20020215131320.E23673@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Michael Sinz <msinz@wgate.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C6BE18F.7B849129@wgate.com> <20020215124036.C23673@unthought.net> <3C6CF4AA.8040808@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3C6CF4AA.8040808@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Feb 15, 2002 at 12:44:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 12:44:42PM +0100, Martin Dalecki wrote:
> Jakob Østergaard wrote:
...
> >
> >What I want is "core.[process name]" eventually with a ".[pid]" appended.  A
> >flexible scheme like your patch implements is very nice.   Actually having
> >the core files in CWD is fine for me - I mainly care about the file name.
> >
> 
> Please execute the size command on the core fiel:
> 
> size core
> 
> to see why this isn't needed.
> 

Huh ?

I suppose you mean, that I can get the name of the executable that caused the
core dump, when running size - right ?

Well, you can do that easier with the file command.

But that doesn't prevent my 7 other processes from overwriting the core file
of the 8'th process which was the first one to crash.   Multi-process systems
can, on occation, produce such "domino dumps".   Separate names is a *must have*.

And having process names is nicer than having PIDs - I don't mind if my core
files are over-written on subsequent runs, actually it's nice (keeps the disks
from filling up).

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
