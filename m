Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSGLOxN>; Fri, 12 Jul 2002 10:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSGLOxM>; Fri, 12 Jul 2002 10:53:12 -0400
Received: from mark.mielke.cc ([216.209.85.42]:24079 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316574AbSGLOxL>;
	Fri, 12 Jul 2002 10:53:11 -0400
Date: Fri, 12 Jul 2002 10:49:30 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Tom Oehser <tom@toms.net>
Cc: Daniel Phillips <phillips@arcor.de>, Christian Ludwig <cl81@gmx.net>,
       Ville Herva <vherva@niksula.hut.fi>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: bzip2 support against 2.4.18
Message-ID: <20020712104930.C26797@mark.mielke.cc>
References: <E17SwAM-0002e2-00@starship> <Pine.LNX.4.44.0207121023300.23208-100000@conn6m.toms.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207121023300.23208-100000@conn6m.toms.net>; from tom@toms.net on Fri, Jul 12, 2002 at 10:25:37AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 10:25:37AM -0400, Tom Oehser wrote:
> > Do you really?  Why?  Exactly what purpose does it serve to know how your
> > kernel was compressed, considering that it knows how to uncompress itself?
> I already use the name in scripts for tomsrtbt to decide whether the ramdisk
> should be compressed with bzip2 or gzip, since the kernel compression method
> (in my original patch) determines the required ramdisk compression.

This doesn't sound like the proper way to do this. Naming conventions are
notoriously inaccurate and limited, when it comes to detecting capabilities.

It would be far better to have a set of flags at the beginning of the image,
that detailed the capabilities. For example, what if the kernel supported
bzip2 or gzip initrd images? You would be unable to detect whether gzip
initrd images were supported in a bzip2 kernel.

The 'bzImage' name should only change, after an architectural decision
is made to simplify the single name. The 'bzImage' does not define how
the image is compressed, only that it _is_ compressed.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

