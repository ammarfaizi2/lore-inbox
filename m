Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSJ0Sjf>; Sun, 27 Oct 2002 13:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSJ0Sjf>; Sun, 27 Oct 2002 13:39:35 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:777 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262480AbSJ0Sje>; Sun, 27 Oct 2002 13:39:34 -0500
Date: Sun, 27 Oct 2002 10:45:48 -0800
From: jw schultz <jw@pegasys.ws>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: warped security
Message-ID: <20021027184548.GB21165@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
References: <200210270824.g9R8OSI269870@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210270824.g9R8OSI269870@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 03:24:28AM -0500, Albert D. Cahalan wrote:
> 
> As a non-root user:
> 
> a. I can't do readlink() on /proc/1/exe ("ls -l /proc/1/exe")
> b. I can do "cat /proc/1/maps" to see what files are mapped
> 
> That's backwards. If a user can read /proc/1/cmdline, then
> they might as well be permitted to readlink() on /proc/1/exe
> as well. Reading /proc/1/maps is quite another matter,
> exposing more info than the (prohibited) /proc/1/fd/* does.

It seems to have been this way since at least 2.2.  It isn't
exclusive to the /proc/*/exe.  It applies to all symlinks in
/proc/$pid.

As near as i can tell it seems to be a
functional-equivalency carryover from 2.2.  It isn't causing
much harm but i do wonder if this is intentional and if so,
why.  I'm at a loss to see why refusing to allow non-owners
to identify a process's cwd, exe, and root would be
desireable.  The only other things we refuse are mem, fd/
and eviron, the reasons for which are obvious and the
restrictions are per-file rather than as a class.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
