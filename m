Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTKIUm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 15:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbTKIUm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 15:42:27 -0500
Received: from gaia.cela.pl ([213.134.162.11]:15111 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262789AbTKIUmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 15:42:25 -0500
Date: Sun, 9 Nov 2003 21:41:26 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Andrew Morton <akpm@osdl.org>
cc: Krzysztof Halasa <khc@pm.waw.pl>, <linux-kernel@vger.kernel.org>,
       <torvalds@osdl.org>, <marcelo.tosatti@cyclades.com>,
       <alan@lxorguk.ukuu.org.uk>
Subject: Re: Some thoughts about stable kernel development
In-Reply-To: <20031109112604.613d385d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0311092132470.8458-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well yes.  Two days after 2.4.20 was released we discovered a
> data-corrupting bug in ext3.  I had no means of delivering a fix for that
> apart from sticking a bunch of patches on my web page and making a lot of
> noise about it.
> 
> So there is a case for a "2.4.20-post1" release to address such things.

This sort of points to a (possible?) simple solution.  Continue everything 
as it is now, however if we ever (or rather when...) discover a serious 
security or data corruption bug in _the_ _last_ stable 2.4/6.y kernel then 
the patch for it should be posted in the same directory as the kernel as 
incremental 2.x.y-pots/bugfix/errata1 (2 etc) patch.  Obviously this would 
only need to be maintained for the last stable 2.4 or 2.6 kernel (either you
use a distro kernel or you are presumably using the latest one from a 2.x 
branch).  The important part here is that these bugfixes would be 
available straight from the same source as the kernel and thus would be 
hard to miss and easy to check for.

Obviously this could also be extended to include other non-threatening 
bugs, however this would probably be too bothersome to maintain - that's 
why I'd only post security and data corruption bugfixes this way.

Cheers,
MaZe.


