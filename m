Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbULZUSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbULZUSg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 15:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbULZUSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 15:18:35 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:35870 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261153AbULZUSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 15:18:34 -0500
Date: Sun, 26 Dec 2004 21:19:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Mark Williams (MWP)" <mwp@internode.on.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 make script problems
Message-ID: <20041226201936.GA15643@mars.ravnborg.org>
Mail-Followup-To: "Mark Williams (MWP)" <mwp@internode.on.net>,
	linux-kernel@vger.kernel.org
References: <20041226145302.GA12627@linux.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226145302.GA12627@linux.comp>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 01:23:02AM +1030, Mark Williams (MWP) wrote:
> Hi all,
> First... im not on lkml, so can you please CC replies back to me, thanks.
> 
> 
> This is a werid one...
> 
> On running "make menuconfig" for the first time on a freshly extracted
> "linux-2.6.10.tar.bz2" everything works fine.
> 
> >From then on however, running "make" in any form ("make bzImage", "make
> menuconfig", etc) brings on this:
> 
> [root@linux linux-2.6.10]# make bzImage
> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 bzImage
> ....
> 
> which continues until i ctrl-c.

Check your Makefile. It looks like 'make O=...' was executed in the
wrong directory, thus overwriting the original Makefile.

	Sam
