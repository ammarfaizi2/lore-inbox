Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVAKXNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVAKXNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVAKXKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:10:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:40667 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262918AbVAKXGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:06:00 -0500
Date: Tue, 11 Jan 2005 15:05:56 -0800
From: Chris Wright <chrisw@osdl.org>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Matt Mackall <mpm@selenic.com>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111150556.S10567@build.pdx.osdl.net>
References: <20050111214152.GA17943@devserv.devel.redhat.com> <200501112251.j0BMp9iZ006964@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200501112251.j0BMp9iZ006964@localhost.localdomain>; from paul@linuxaudiosystems.com on Tue, Jan 11, 2005 at 05:51:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Davis (paul@linuxaudiosystems.com) wrote:
> >On Tue, Jan 11, 2005 at 04:38:14PM -0500, Lee Revell wrote:
> >> Yes but a bug in an app running as root can trash the filesystem.  The
> >> worst you can do with RT privileges is lock up the machine.
> >
> >several filesystem and IO threads run at prio -10 but not RT.
> >That makes me a bit less sure of your statement....
> 
> Its completely orthogonal. Lee didn't say "tasks running without RT
> can't mess up filesystems". He said "tasks running as root can trash
> the filesystem" and "tasks running as RT can lock up the
> machine". obviously, the intersection point (a root, RT task) is
> double trouble.

This is straying from the core issue...  But, Arjan's saying that an RT
(non-root) task could trash the filesystem if it deadlocks the machine
(because those important fs and IO threads don't run).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
