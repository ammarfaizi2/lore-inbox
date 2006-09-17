Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWIQVQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWIQVQT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 17:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWIQVQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 17:16:19 -0400
Received: from nef2.ens.fr ([129.199.96.40]:53511 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S965105AbWIQVQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 17:16:18 -0400
Date: Sun, 17 Sep 2006 23:16:02 +0200
From: David Madore <david.madore@ens.fr>
To: Joshua Brindle <method@gentoo.org>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060917211602.GA6215@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain> <450451DB.5040104@gentoo.org> <20060917181422.GC2225@elf.ucw.cz> <450DB274.1010404@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450DB274.1010404@gentoo.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 17 Sep 2006 23:16:03 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2006 at 04:39:16PM -0400, Joshua Brindle wrote:
> The benefits of this are so minuscule and the cost is so high if you are 
> ever to use it that it simply won't happen..

I'm withdrawing that patch anyway, in favor of a LSM-style approach,
the "cuppabilities" module (cf. the patch I posted a couple of hours
ago with that word in the title, and I'll be posting a new version in
a day or so, or cf. <URL:
http://www.madore.org/~david/linux/cuppabilities/
 >).  In this case, the relative cost will be lower since the
security_ops->inode_permission() hook is called no matter what.

But I agree that the value of restricting open() is very dubious and
it was intended mostly as a demonstration.  So if there is strong
opposition to this sort of thing, I'll remove it.

Happy hacking,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
