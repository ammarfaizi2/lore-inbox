Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292959AbSB0VlX>; Wed, 27 Feb 2002 16:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292978AbSB0Vkd>; Wed, 27 Feb 2002 16:40:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27911 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S292980AbSB0VkF>; Wed, 27 Feb 2002 16:40:05 -0500
Date: Wed, 27 Feb 2002 22:39:54 +0100
From: Jan Kara <jack@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Quota & XFS patch
Message-ID: <20020227213954.GA7598@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020227160938.GA22460@atrey.karlin.mff.cuni.cz> <Pine.GSO.4.21.0202271139480.12074-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0202271139480.12074-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 27 Feb 2002, Jan Kara wrote:
> 
> >   Hello,
> > 
> >   I'm sending you Nathan's patch which implements things
> > in quotactl interface needed for XFS. If you can remember
> > the patch was already floating around some time
> > ago and was generally accepted... Please apply (it will
> > at least simplify patching of kernels for XFS).
> 
> Why are you leaving some copy_from_user() in methods?  Either the structures
> you are passing are fs-independent and everybody would be better off with
> having them copied in one place or they are not, and then API is completely
> broken.
  Umm... I'm not sure I understand your objections - as I'm looking into the patch
all the copy_from_user() were moved from functions into sys_quotactl(). The
only thing you might not like is that XFS has extra structures and calls...
I don't like this too much either but XFS has different quota model so
creating common interface (structures) is a problem.

						Thanks for comments
									Honza

PS: Alan is not going to accept the patch anyway because he doesn't want further
  interface differences between his and Linus's tree. But anyway discussion on this
  topic is useful because I have similar patch for 2.5...

--
Jan Kara <jack@suse.cz>
SuSE CR Labs
