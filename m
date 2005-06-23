Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVFWA2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVFWA2A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVFWA2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:28:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261764AbVFWA1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:27:21 -0400
Date: Wed, 22 Jun 2005 17:29:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <42B9FCAE.1000607@pobox.com>
Message-ID: <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
 <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
>
> > But, like branches, it means that if you want a tag, you need to know the 
> > tag you want, and download it the same way you download a branch.
> 
> Still -- that's interesting data that no script currently tracks.  You 
> gotta fall back to rsync.

Something like

	git-ssh/http-pull -w tags/<tagname> tags/<tagname> <url>

_should_ hopefully work now (and the "-a" flag should mean that you also 
get all the objects needed for the tag).

I've not tested it, as usual, but it should work as of today thanks to 
Daniel Barkalow fixing the pulling of arbitrary objects.

		Linus
