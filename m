Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbTCSW3P>; Wed, 19 Mar 2003 17:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbTCSW3O>; Wed, 19 Mar 2003 17:29:14 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:47331 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263279AbTCSW3N>;
	Wed, 19 Mar 2003 17:29:13 -0500
Date: Wed, 19 Mar 2003 23:40:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] cvsps support for parsing BK->CVS kernel tree logs
Message-ID: <20030319224003.GT30541@dualathlon.random>
References: <20030319213738.GR30541@dualathlon.random> <Pine.LNX.4.44.0303191715390.19298-200000@admin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303191715390.19298-200000@admin>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 05:21:12PM -0500, David Mansfield wrote:
> On Wed, 19 Mar 2003, Andrea Arcangeli wrote:
> 
> > I'm downloading the new version now... ;) thanks
> > 
> > > The file is actualy a substring match.  If the -f argument matches as a 
> > 
> > so it doesn't sound a regex. Being able to specify more than 1 -f would
> > be very useful. Either that or regex would do it fine too with
> > '^net/core', so as far as I can write stuff like -f
> > '^net/core|^net/ipv4' I'm fine.
> > 
> > I also think using match by default in the regex is cleaner. So I can
> > write -f 'net/core|net/ipv4' w/o bothering about the ^ because it become
> > implicit. And I can still use '.*net/core.*' if I want a substring
> > regex. I think substring search will be not common.
> > 
> > But really, any kind of way you implement the 'multiple file' thing is
> > fine as far as I can specify more than 1 file ;).
> > 
> 
> Attached is a patch (on top of previous which is on top of 2.0b5) changes 
> the -f to regex match.  The regex is of course slightly slower than 
> 'strstr' but I agree the advantage is worth it.
> 
> It differs slightly in syntax (c library regex just works this way):
> 
> cvsps -f '^net/core\|^net/ipv4'
>                    ^
>                    You must escape the | symbol to separate the regex.
> 
> Try it out!

ouch I did it too ;) I used the EXP_EXTENDED so I don't need to use \|,
I'm not used to it.

Andrea
