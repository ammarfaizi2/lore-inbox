Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbUJ0W2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbUJ0W2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbUJ0WYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:24:54 -0400
Received: from basmati.dododge.net ([204.245.156.209]:1752 "HELO
	basmati.dododge.net") by vger.kernel.org with SMTP id S262932AbUJ0WY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:24:26 -0400
Date: Wed, 27 Oct 2004 18:35:46 -0400
From: Dave Dodge <dododge@dododge.net>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Cc: uclibc@uclibc.org, linux-kernel@vger.kernel.org
Subject: Re: [uClibc] Re: [OT] Re: The naming wars continue...
Message-ID: <20041027223546.GI24083@basmati>
References: <20041026203137.GB10119@thundrix.ch> <417F2251.7010404@zytor.com> <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua> <20041027154828.GA21160@thundrix.ch> <Pine.LNX.4.60.0410271803470.614@alpha.polcom.net> <20041027161402.GC21160@thundrix.ch> <Pine.LNX.4.60.0410271830430.614@alpha.polcom.net> <yw1xu0sgnkbb.fsf@mru.ath.cx> <20041027211138.GE24083@basmati> <yw1xhdofoobg.fsf@mru.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xhdofoobg.fsf@mru.ath.cx>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 11:15:15PM +0200, Måns Rullgård wrote:
> Dave Dodge <dododge@dododge.net> writes:
> > If I recall correctly, in the GoboLinux case
[...]
> > I believe "/bin" is a symlink to the bin directory in the main
> > install prefix, but there are patches so that while "/bin" can be
> > used for lookups it does not appear when you list "/".
> 
> If there's one thing I detest, it is such hiding of files.  The GUI in
> MacOSX does such things too, even /tmp is hidden there.

I believe Gobo only has paths such as "/bin" for legacy compatibility
(for example scripts starting with #!/bin/...).  "/dev" is another
case, since that isn't where Gobo puts its devices, but lots of things
are going to assume they can use "/dev/zero" and "/dev/null".

> It's visible from a shell though.

Gobo actually does it in the kernel; whether that's better or worse
depends on your point of view.  There's a command-line tool "GoboHide"
that provides a list of hidden things:

  http://gobolinux.org/index.php?page=doc/articles/gobohide

I think all of the things hidden in a normal GoboLinux desktop are
just legacy symlinks, and the real locations they point to are fully
visible.  Unlike MacOS, where the Finder ignores a lot of real
directories and applications (I've been bitten there by "/tmp"
myself).
                                                  -Dave Dodge
