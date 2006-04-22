Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWDVTPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWDVTPp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWDVTPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:15:45 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:29113 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750966AbWDVTPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:15:45 -0400
Date: Sat, 22 Apr 2006 16:28:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Message-ID: <20060422142853.GB25926@mars.ravnborg.org>
References: <1145672241.16166.156.camel@shinybook.infradead.org> <20060422093328.GM19754@stusta.de> <1145707384.16166.181.camel@shinybook.infradead.org> <20060422141410.GA25926@mars.ravnborg.org> <20060422142043.GD5010@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060422142043.GD5010@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >...
> 
> What exactly is the problem with creating the userspace ABI in 
> include/kabi/ and letting distributions do an
>   cd /usr/include && ln -s kabi/* .
> ?
> 
> Or with creating the userspace ABI in include/kabi/ and letting 
> distributions install the subdirs of include/kabi/ directly under 
> /usr/include?
> 
> These are two doable approaches with a new kabi/ that avoid needless 
> breaking of userspace.

First off:
There are many other users that poke direct in the kernel source also.

Secondly and more importantly:
Introducing kabi/ you will have a half solution where several users will
have to find their stuff in two places for a longer period.
kabi/ does not allow you to do it incrementally - it requires you to
move everything over from a start.
You may argue that you can just move over a little bit mroe than needed
but then we ruin the incremental approach.

	Sam
