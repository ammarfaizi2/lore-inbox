Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTKCDLw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 22:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTKCDLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 22:11:52 -0500
Received: from netrealtor.ca ([216.209.85.42]:20656 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S261882AbTKCDLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 22:11:50 -0500
Date: Sun, 2 Nov 2003 22:10:12 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Using proc in chroot environments
Message-ID: <20031103031012.GA30460@mark.mielke.cc>
References: <20031102204934.GB54@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102204934.GB54@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 09:49:34PM +0100, DervishD wrote:
>     I'm using a chroot environment on my main disk as a 'crash test
> dummy', and I need to access the proc filesystem inside it. Since
> hard links are not allowed for directories, the only solution I can
> think of is to mount proc inside the chroot environment just after
> chrooting. This works, I've tested, but I have two problems:
> ...
>     The perfect solution for me is to hardlink the proc directory of
> the chrooted environment to the proc directory on the true root dir,
> but since this is not possible, whan can I do instead of remounting a
> second copy of proc (which, by the way, makes /proc/mounts a little
> bit weird...)?

It sounds to me, as if you want something like UML... :-)

chroot environments are traditionally quite minimal, meaning that they
usually don't require /dev/pts, /proc, etc.

One approach that I have seen taken, is for privileged information to be
queried through a non-chroot'ed process by the chroot'ed process.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

