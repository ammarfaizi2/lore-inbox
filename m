Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286221AbSAEVnw>; Sat, 5 Jan 2002 16:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285632AbSAEVnk>; Sat, 5 Jan 2002 16:43:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56372 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S285630AbSAEVna>; Sat, 5 Jan 2002 16:43:30 -0500
To: Phil Oester <kernel@theoesters.com>
Cc: Nicholas Knight <nknight@pocketinet.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
In-Reply-To: <004b01c1955e$ecbc9190$6400a8c0@philxp>
	<20020104220240.233ae66a.skraw@ithnet.com>
	<WHITExcPbVzv2N2Ku2000000c76@white.pocketinet.com>
	<20020104172418.A28715@ns1.theoesters.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Jan 2002 14:41:04 -0700
In-Reply-To: <20020104172418.A28715@ns1.theoesters.com>
Message-ID: <m11yh4tr0v.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester <kernel@theoesters.com> writes:

> On Fri, Jan 04, 2002 at 04:42:43PM -0800, Nicholas Knight wrote:
> > The one catch is that -j is specified without a number.
> 
> [snip superfluous description of what 'make -j' implies]
> 
> > number, your system is dead. A user issue because it seems the user is 
> > using the option without fully comprehending the consequences.
> 
> eh?  Trust me - i understand the implications of make -j.  It's not an
> unreasonable test, especially on a machine with 1gb ram/swap.  For reference,
> read Rik's email regarding his reverse VM patch:
> 
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101007711817127&w=2
> 
> Might be enlightening

Yes.  It sounds like he Rick slowed down fork enough the system didn't fall
over.  There may be some other policy changes as well.  But my hunch is that
it is a fork speed thing.  If all that happens is that the system hits
OOM when subjected to an unreasonable load I don't see this as a problem.

The truly interesting question is what happens when you and more swap.
With sufficient swap will it work?

Eric
