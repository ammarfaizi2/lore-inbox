Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVF1WII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVF1WII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVF1WGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:06:16 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:14252 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261502AbVF1WA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:00:59 -0400
Date: Tue, 28 Jun 2005 14:47:55 -0400
From: Christopher Li <hg@chrisli.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Andrew Thompson <andrewkt@aktzero.com>, Petr Baudis <pasky@ucw.cz>,
       mercurial@selenic.com, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050628184755.GA2255@64m.dyndns.org>
References: <andrewkt@aktzero.com> <42C16877.6000909@aktzero.com> <200506282154.j5SLsETL010486@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506282154.j5SLsETL010486@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 05:54:14PM -0400, Horst von Brand wrote:
> 
> And is exactly the wrong way around. Even RCS stored the _last_ version and
> differences to earlier ones (you'll normally want the last one (or
> something near), and so occasionally having to reconstruct earlier ones by
> going back isn't a big deal; having to build up the current version by
> starting from /dev/null and applying each and every patch that ever touched
> the file each time is expensive given enough history, besides that any

Mercurial store a full text node when it detect the delta gets too long
to reach certain point. So what you describe here will not happen on
mercurial. Having it append only is a very nice feature.

> error in the file is guaranteed to destroy the current version, not
> (hopefully) just making old versions unavailable).  It also means that
> losing old history (what you'll want to do once in a while, e.g. forget
> everything before 2.8) is simple: Chop off at the right point.

You can still chop of the history before the full node, but rebuilding the
repositories. Mercurial save some much space that you would wonder why do you
what to chop the history if you can keep it.

Chris


