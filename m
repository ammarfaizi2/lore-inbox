Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313205AbSDDPp2>; Thu, 4 Apr 2002 10:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSDDPpT>; Thu, 4 Apr 2002 10:45:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3382 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313201AbSDDPpH>; Thu, 4 Apr 2002 10:45:07 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>
	<20020403191538.GA7211@opus.bloom.county>
	<m13cycrvsh.fsf@frodo.biederman.org>
	<20020404141035.GB7211@opus.bloom.county>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Apr 2002 08:38:34 -0700
Message-ID: <m1y9g3qxs5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> writes:

> On Wed, Apr 03, 2002 at 08:23:58PM -0700, Eric W. Biederman wrote:
> > Tom Rini <trini@kernel.crashing.org> writes:
> > 
> > > On Wed, Apr 03, 2002 at 09:41:55AM -0700, Eric W. Biederman wrote:
> > > 
> > > > In imitation of the arm and ppc ports a CONFIG_CMDLINE option is also
> > > > implemented.
> > > 
> > > Just wondering, why didn't you do it with a
> > > CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE set of options?  The way you did it,
> > > I _think_ you can't actually get a help msg from 'config' or
> > > 'oldconfig', you'll just set the commandline to '?'.
> > 
> > I just tested it and oldconfig at least works.
> 
> That's sort of supprising.

True.  But I'm not complaining.

What I find funny is that with menuconfig I can't backspace when
editing the command line.
 
> The way you're doing it now, you're sticking it into final image itself
> tho, and passing it along.  If you're not going to be able to change the
> commandline, why not handle it all in C? eg:
> strcpy(cmd_line, CONFIG_CMDLINE);
> if ( passed a new commandline )
>    strcpy(cmd_line, new_cmdline);

I actually put it at a location where you can edit it in the final
image.  Which is why I don't do it all in C.  I have even documented
this...

Eric
