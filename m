Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSKCFYf>; Sun, 3 Nov 2002 00:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSKCFYf>; Sun, 3 Nov 2002 00:24:35 -0500
Received: from codepoet.org ([166.70.99.138]:19897 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S261645AbSKCFYe>;
	Sun, 3 Nov 2002 00:24:34 -0500
Date: Sat, 2 Nov 2002 22:31:09 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103053109.GA19281@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu> <Pine.LNX.4.44.0211022101090.20616-100000@mooru.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211022101090.20616-100000@mooru.gurulabs.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Nov 02, 2002 at 09:04:07PM -0700, Dax Kelson wrote:
> On Sat, 2 Nov 2002, Alexander Viro wrote:
> 
> > 	<shrug> that can be done without doing anything to filesystem.
> > Namely, turn current "nosuid" of vfsmount into a mask of capabilities.
> > Then use bindings instead of links.  *Note* - binary _is_ marked suid,
> > mask tells which capabilities _not_ to gain.  It's OK - attempt to
> > link(2) to the thing using binding will see that oldname and newname
> > are within different vfsmounts, so instead of link to suid-root binary
> > you get -EXDEV.
> 
> Any thoughts on how /usr/bin/(rpm|dpkg) copes with setting up the binding
> when installing a package?

postint script

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
