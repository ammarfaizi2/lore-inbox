Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTEAAK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTEAAK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:10:58 -0400
Received: from air-2.osdl.org ([65.172.181.6]:47540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262609AbTEAAK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:10:56 -0400
Date: Wed, 30 Apr 2003 17:21:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel source tree splitting
Message-Id: <20030430172102.69e13ce9.rddunlap@osdl.org>
In-Reply-To: <200304301946130000.01139CC8@smtp.comcast.net>
References: <200304301946130000.01139CC8@smtp.comcast.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm probably misreading this...but,

Have you tried this yet?  Does it modify/customize all Kconfig
and Makefiles for the selected tree splits?

A few days ago, in one tree, I rm-ed arch/{all that I don't need}
and drivers/{all that I don't need}.
After that I couldn't run "make *config" because it wants all of
those files, even if I don't want them.

So there are many edits that needed to be done in lots of
Kconfig and Makefiles if one selectively pulls or omits certain
sub-directories.



On Wed, 30 Apr 2003 19:46:13 -0400 rmoser <mlmoser@comcast.net> wrote:

| Eh, Linus won't be happy making a bunch of tarballs.
| I've made it less work if you read the message here...
| 
| The message mirrored at:
| 
| http://marc.theaimsgroup.com/?l=linux-kernel&m=105173077417526&w=2
| 
| Shows my pre-thought on this subject.  I thought a bit more,
| and began to come up with a simple sketch to lead the
| way in case anyone becomes interested.
| 
| First off, the kernel tarballs would be built by a script
| that splits the source tree apart appropriately and tar's it
| up.  How this is done is explained.
| 
| Second off, there's always a script to download that runs
| wget and gets the source tree from which it was downloaded.
| The whole thing.  As in, every tarball is downloaded and
| untar'd for the user, assembling the full kernel source
| tree (as it would be if you untar'd it now).
| 
| Now, I explained LOD's in that message above in small
| detail.  But, for clarity, LOD's are files which explain
| which pieces of source in the kernel tree belong to the
| LOD; what gets added to the config; where their makefiles
| are; what config options depend on other linux options;
| and what groups these LOD's are in.
| 
| A command such as `make disttree` should read the LOD's,
| split apart each linux option, tar 'em together, and
| then compress the tar's.  Then Linus could just scp the
| new directory of tar's and a script up.
| 
| As for download, the script that goes up can be
| downloaded (duh), and then run (... why do I bother?).
| Now this script would run in "dumb mode" (unless the
| user tells it not to maybe?) and rip down the whole
| tree, untar it, and rebuild the original source tree.
| I think.  I'm not sure, I really haven't tried yet.
| I'll tell you how it works after it's implimented, if
| ever that happens.  This would likely require wget.
| 
| Of course there's always the ftp method.  Go download
| the pieces you want, untar 'em, copy 'em to the same
| directory, and the build system adjusts.  but newbies
| and developers, for completely opposite reasons, will
| want to use the script in dumb mode.
| 
| For experienced users, this will make configuration
| somewhat easier, as the user can avoid being prompted
| for irrelavent drivers.  This is just a concept idea,
| not a fully thought-out idea.  What do you think?
| 
| --Bluefox Icy

--
~Randy
