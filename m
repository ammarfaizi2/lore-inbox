Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290000AbSAPQjC>; Wed, 16 Jan 2002 11:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290434AbSAPQix>; Wed, 16 Jan 2002 11:38:53 -0500
Received: from willow.seitz.com ([207.106.55.140]:32272 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S290000AbSAPQip>;
	Wed, 16 Jan 2002 11:38:45 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Wed, 16 Jan 2002 11:38:40 -0500
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020116113840.A16168@willow.seitz.com>
In-Reply-To: <20020115145324.A5772@thyrsus.com> <20020115152643.A6846@willow.seitz.com> <20020115230211.A5177@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020115230211.A5177@thyrsus.com>; from esr@thyrsus.com on Tue, Jan 15, 2002 at 11:02:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 11:02:11PM -0500, Eric S. Raymond wrote:
> Ross Vandegrift <ross@willow.seitz.com>:
> > I tried CML2 (2.1.2) yesterday with Linux 2.4.17 and found that I
> > couldn't turn on suppression ('S' didn't seem to toggle, only
> > disable suppression, which was already off) and entering into a
> > submenu marked FROZEN locked up the configurator.
> 
> I'd sure like to know how you managed this.  Since 2.1.2 frozen symbols
> are no longer supposed to be visible at all.  Can you reproduce this?
> Can you give me the recipe for reproducing it?

Here's what I do to reproduce it:

$ tar yxvf linux-2.4.17.tar.bz2
...
$ cd cml2-2.1.2
$ ./install-cml2 /home/ross/linux
Examining your build environment...
Good. You have Python 2.x installed as 'python' already.
Python looks sane...
Good, your python has curses support linked in.
Good, your python has Tk support linked in.
Compiling file list...
Operating on /home/ross/linux...
Installing new files...
Merging in CML2 help texts from Configure.help...
Modifying configuration productions...
You are ready to go, cd to /home/ross/linux.
$ cd ../linux
$ make config

At this point the rules are compiled and a dialog box indicates that
Suppression has been turned off (press any key to continue).  I hit any key and
am presented with the first menu.

The first selection at the top of the screen is "Intel or Processor type
(FROZEN)" and it is highlighted as the default selection.  If I press enter
*boom*, I'm locked solid.  If I move the active selection off of this menu item,
I can't move back to it, though it remains visible.  If I enter a submenu, the
frozen processor type menu is gone.

It's reproduceable with fresh trees (as above), existing trees, and at least
linux 2.4.12 and linux 2.4.17 (the two kernel tarballs I have lying around).

I'm planning on trying this on a Debian testing box I have at work at some
point.

Ross Vandegrift
ross@willow.seitz.com
