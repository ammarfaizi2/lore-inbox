Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290828AbSBLIeO>; Tue, 12 Feb 2002 03:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290833AbSBLIeE>; Tue, 12 Feb 2002 03:34:04 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:3339 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S290828AbSBLId5>; Tue, 12 Feb 2002 03:33:57 -0500
Date: Tue, 12 Feb 2002 09:33:55 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: linux-kernel@vger.kernel.org
Cc: Theodore Tso <tytso@mit.edu>, SA products <super.aorta@ntlworld.com>
Subject: Re: faking time
Message-ID: <20020212093355.A29445@devcon.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	SA products <super.aorta@ntlworld.com>
In-Reply-To: <3C67AFD3.722C5471@ntlworld.com> <20020211224723.A5514@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020211224723.A5514@thunk.org>; from tytso@mit.edu on Mon, Feb 11, 2002 at 10:47:23PM -0500
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 10:47:23PM -0500, Theodore Tso wrote:
> 
> Here's an LD_PRELOAD shared library that will do the trick... just
> export the environment variable FAKETIME with the time that you'd
> like, and then export the LD_PRELOAD environment variable to point
> that the faketime.so library, and then execute your program.  All
> programs that have these two environment variables set will have their
> time faked out accordingly.

But note that this doesn't work with programs linked statically. If
you must fool one of those, ptrace() is the only way to do it without
some sort of kernel patch or module I think.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
