Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVKUB5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVKUB5J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVKUB5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:57:09 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:29349 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932171AbVKUB5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:57:08 -0500
Subject: Re: [RFC] Documentation dir is a mess
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <20051121003033.GA11302@kroah.com>
References: <438069BD.6000401@gmail.com>  <20051121003033.GA11302@kroah.com>
Content-Type: text/plain
Date: Sun, 20 Nov 2005 20:56:59 -0500
Message-Id: <1132538219.5706.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-20 at 16:30 -0800, Greg KH wrote:
> On Sun, Nov 20, 2005 at 01:19:09PM +0100, Xose Vazquez Perez wrote:
> > hi,
> > 
> > _today_ Documentation/* is a mess of files. It would be good
> > to have the _same_ tree as the code has:
> 
> Do you have a proposal as to what specific files in that directory
> should go where?  Just basing it on the source tree will not get you
> very far...

Actually I think it's a good start.  When I'm looking for documentation,
I usually just do a grep -r on the Documentation directory hoping I get
a correct hit and then manually look through all the results I get.  It
does get tedious, and I miss things all the time.

So how about something like the following:

Documentation/kernel:
  Holds things like atomic_ops.txt, cpusets.txt cpu-freq(dir),
kobjects.txt (etc).

Documentation/fs:
  (already a filesystems directory)

Documentation/crypto:
  (also already there)

Documentation/drivers:
  breaking this up to all the files that deal with specific functions in
the drivers directory (like tty.txt, video4linux, etc)

Documentation/arch:
  Each arch can have its own directory.

Documentation/net:
  Network stuff

Documentation/mm:
  memory management stuff

And etc, etc, for all in the main directory.

What would need to be done is look at each file already in Documentation
and see where it should go and put it there.  The actual Documentation
directory should have no text files and only directories, with the
exception of documentation explaining how the Documentation directory is
ordered.

Also, this doesn't need to be limited to the kernel hierarchy
directories, but also directories like:

Documentation/build:
  how to build the kernel

Documentation/debug:
  debugging options

Documentation/development
  things that may help out new developers.

And whatever else can be thought of.

If something like this _is_ desired, I wouldn't mind spending some extra
free time reading each of the files in documentation and ordering them
(I might actually learn something doing this too :-).

-- Steve


