Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSEMI5f>; Mon, 13 May 2002 04:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSEMI5e>; Mon, 13 May 2002 04:57:34 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:44553 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S290593AbSEMI5d>; Mon, 13 May 2002 04:57:33 -0400
Date: Mon, 13 May 2002 01:57:24 -0700
From: jw schultz <jw@pegasys.ws>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513015724.I14698@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org> <abmi0f$ugh$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2002 at 08:06:39PM +0000, Linus Torvalds wrote:
> In article <20020512010709.7a973fac.spyro@armlinux.org>,
> Ian Molton  <spyro@armlinux.org> wrote:
> >
> >I dont know who to write to about this, but the changelogs for
> >2.4.19-pre on kernel.org are COMPLETELY illegible.
> 
> Hmm..
> 
> You're definitely right about the BK version numbers, since those are
> meaningless anyway (they are only meaningful within one BK tree, and
> they change over time when you merge different trees together.
> 
> The 2.4.x changelogs seem to be done with my "release" scripts, but
> additionally they don't have the same kind of detailed information that
> the 2.5.x kernels have, and yes, the result is fairly ugly.
> 
> What are peoples opinion about the "full" changelog format that v2.5.x
> kernels have? Should we sort that too by author?
> 
> Perl is the obvious choice for doing transformations like these.  Is
> anybody willing to write a perl script that does the "sort by author"
> thing?
> 
> I'll remove the date/BK ID thing, so that my unsorted changelogs would
> look like the appended thing.  But yes, sorting (and merging) by author
> would probably be a good thing. (My BK changelog scripts can also add
> markers around the actual log message, to make parsing easier).
> 
> 		Linus
> 

Rather than sort by author i, and i suspect others, would
prefer the top-level sort be by subsystem or a recognizable
aspect (ext2fs, VM, sched, cleanup, etc).  That way we could
quickly scan for the patches that relate to areas of
interest.  I am aware that currently many patches aren't
even labled suitably but if we start doing this then
eventually it will get better.

Also where a set of patches are included it would be nice if
they could be merged like so:

|<bigenius@northpole.org>
|	[devicefs] blah blah blah [1/6]
|	
|	fixed the whosit
|
|<bigenius@northpole.org>
|	[devicefs] blah blah blah [2/6]
|
|	improved error report
|
|<bigenius@northpole.org>
|	[devicefs] blah blah blah [4/6]
|
|	move locking down a layer (requires 1)


Might become

|	** devicefs **
|<bigenius@northpole.org>
|	[devicefs] blah blah blah [1,2,4/6]
|	
|	fixed the whosit
|
|	improved error report
|
|	move locking down a layer (requires 1)

Of course this would be further down the line.
