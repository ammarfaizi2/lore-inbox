Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbSKSV6S>; Tue, 19 Nov 2002 16:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267399AbSKSV6S>; Tue, 19 Nov 2002 16:58:18 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8207 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267345AbSKSV6R>;
	Tue, 19 Nov 2002 16:58:17 -0500
Date: Tue, 19 Nov 2002 23:05:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Jackson <brian-kernel-list@mdrx.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: Separate obj/src dir
Message-ID: <20021119220501.GB4308@mars.ravnborg.org>
Mail-Followup-To: Brian Jackson <brian-kernel-list@mdrx.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
References: <20021119201110.GA11192@mars.ravnborg.org> <20021119205154.9616.qmail@escalade.vistahp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119205154.9616.qmail@escalade.vistahp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 02:51:54PM -0600, Brian Jackson wrote:
> Sam Ravnborg writes: 
> 
> I wonder how hard it would be to do this for other files types. It would be 
> sort of handy to be able to copy a single file out of the source tree into 
> the build tree, and have the build use the copy in the build tree. Example: 
> you want to test a one liner in drivers/scsi/sd.c, you could just copy sd.c 
> into the build tree, and make the change and test it out. That could be a 
> huge space savings. That would help out those of us that are stuck with 
> tiny hard drives in our laptops :) 
It actually works. But that is a side-effect and not something I had
planned.
I tried your example and kbuild uses the sd.c located in OBJTREE if
present. make searches lokal directory before VPATH directory.
And when sd.c is deleted the commandline changes and the original file
is compiled again.

But I can see several drawbacks with this, especially dealing with .h
files, or .c files included by other .c files.
So this is not a trustable feature.

	Sam
