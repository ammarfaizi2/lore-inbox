Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbUJ0VIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbUJ0VIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbUJ0VGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:06:54 -0400
Received: from basmati.dododge.net ([204.245.156.209]:56535 "HELO
	basmati.dododge.net") by vger.kernel.org with SMTP id S262748AbUJ0VAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:00:19 -0400
Date: Wed, 27 Oct 2004 17:11:38 -0400
From: Dave Dodge <dododge@dododge.net>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Cc: uclibc@uclibc.org, linux-kernel@vger.kernel.org
Subject: Re: [uClibc] Re: [OT] Re: The naming wars continue...
Message-ID: <20041027211138.GE24083@basmati>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041026203137.GB10119@thundrix.ch> <417F2251.7010404@zytor.com> <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua> <20041027154828.GA21160@thundrix.ch> <Pine.LNX.4.60.0410271803470.614@alpha.polcom.net> <20041027161402.GC21160@thundrix.ch> <Pine.LNX.4.60.0410271830430.614@alpha.polcom.net> <yw1xu0sgnkbb.fsf@mru.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xu0sgnkbb.fsf@mru.ath.cx>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 07:27:04PM +0200, Måns Rullgård wrote:
> Grzegorz Kulewski <kangur@polcom.net> writes:
> > 5. I am thinking of changing directory structure (and some other
> > things) some more... For example placing every package in its own dir
> > - like /apps/gcc/3.4.2/<install date>/{bin,lib,...} and placing
> 
> I've been placing things in /opt/package/version for quite a while.

That's essentially what the GoboLinux distribution does, except that
it does it for everything down to and including core stuff like "sh"
and "ls".

> I use a perl script to set the *PATH environment variables to point at
> whatever versions I choose for each package.

If you have enough things installed you might run into problems with
the size of PATH (perhaps unlikely on Linux, but I recall hitting
the limit on Solaris at one point).

When I used to do this on Solaris, my most recent solution was to use
GNU stow to create symlinks from a single prefix to all of the
installed packages.  Then I'd only need one additional entry in PATH,
MANPATH, and so on.  stow made it easy enough to add and remove
packages, though there were trouble spots with duplicate files such as
the emacs info directory.

If I recall correctly, in the GoboLinux case gcc 3.4.2 would be
installed in "/Programs/GCC/3.4.2/{bin,lib,...}".  A symlink from
"/Programs/GCC/Current" to "3.4.2" would select that as the current
version.  The Current trees are symlinked into a single prefix (like I
did with stow).  Gobo has scripts to manage all of this.  I believe
"/bin" is a symlink to the bin directory in the main install prefix,
but there are patches so that while "/bin" can be used for lookups it
does not appear when you list "/".

                                                  -Dave Dodge
