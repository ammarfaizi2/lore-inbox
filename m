Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWIJQJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWIJQJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 12:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWIJQJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 12:09:56 -0400
Received: from nef2.ens.fr ([129.199.96.40]:47120 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932269AbWIJQJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 12:09:55 -0400
Date: Sun, 10 Sep 2006 18:09:54 +0200
From: David Madore <david.madore@ens.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060910160953.GA6430@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157905393.23085.5.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 10 Sep 2006 18:09:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 05:23:13PM +0100, Alan Cox wrote:
> CAP_REG_EXEC seems meaningless, I can do the same with mmap by hand for
> most types of binary execution except setuid (which is separate it
> seems)

Actually I meant those caps to be more of a proof of concept than as a
really useful set, so I have nothing against CAP_REG_EXEC being
deleted.  However, it still performs one (small) function even in the
absence of suid/sgid executables: you can execute files with omde --x
which you can't do with mmap().  (Also, I'm not 100% sure the kernel
doesn't do some magic things on exec(), perhaps some magic forms of
accounting or whatever, which you couldn't do with mmap().)

> Given the capability model is accepted as inferior to things like
> SELinux policies why do we actually want to fix this anyway. It's
> unfortunate we can't discard the existing capabilities model (which has
> flaws) as well really.

Can a non-root user create limited-rights processes without assistance
from the sysadmin, under SElinux?  I was under the impression that it
wasn't the case.  Also, SElinux is immensely more difficult to
understand and operate with than a mere set of capabilities: and I
think that simplicity is (sometimes) of value.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
