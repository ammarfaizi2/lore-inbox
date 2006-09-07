Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422671AbWIGRev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbWIGRev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 13:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWIGRev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 13:34:51 -0400
Received: from nef2.ens.fr ([129.199.96.40]:10508 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1422671AbWIGReu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 13:34:50 -0400
Date: Thu, 7 Sep 2006 19:34:49 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060907173449.GA24013@clipper.ens.fr>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Thu, 07 Sep 2006 19:34:49 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 01:01:48AM +0000, Casey Schaufler wrote:
> --- David Madore <david.madore@ens.fr> wrote:
> > doesn't it make sense to implement them in the same
> > framework?
> 
> I'm certainly not convinced that you'd
> want that. Think of all the programs that
> would have to be marked with CAP_FORK.

They wouldn't have to be marked: capabilities are inherited by
default, with my patch (as is the Unix tradition: euid=0 or {r,s}uid=0
are preserved upon execve()), normal processes have CAP_FORK and just
pass it on if you don't do something special to remove it.

> > Rather
> > than trying to reproduce the same rules in a
> > different part of the
> > kernel, causing code reduplication which would
> > eventually, inevitably,
> > fall out of sync...  I think it's easier for
> > everyone if under- and
> > over-privileges are treated in a uniform fashion.
> 
> This again assumes that you want to require
> that in general processes run with some
> capabilities.

Yes.  In general, processes have all "regular" capabilities, and they
are inherited normally.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
