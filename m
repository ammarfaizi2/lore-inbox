Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUDPX4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263931AbUDPX4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:56:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:60055 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263895AbUDPX40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:56:26 -0400
Date: Fri, 16 Apr 2004 16:56:21 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alex Riesen <fork0@users.sourceforge.net>, Chris Wright <chrisw@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: POSIX message queues, libmqueue: mq_open, mq_unlink
Message-ID: <20040416165621.V21045@build.pdx.osdl.net>
References: <4080060F.7030604@redhat.com> <20040416213851.GA1784@steel.home> <20040416152217.C22989@build.pdx.osdl.net> <20040416234303.GA1932@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040416234303.GA1932@steel.home>; from fork0@users.sourceforge.net on Sat, Apr 17, 2004 at 01:43:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alex Riesen (fork0@users.sourceforge.net) wrote:
> Chris Wright, Sat, Apr 17, 2004 00:22:17 +0200:
> > The kernel interface is simple and clean.  And in fact, requires no
> > slashes else you'll get -EACCES.  It's not POSIX, but the library
> > interface is.
> > 
> > We just discussed this yesterday:
> > 
> > http://marc.theaimsgroup.com/?t=108205593100003&r=1&w=2
> 
> now, what's is the check in the library for? BTW, it is returning the
> other error code (EINVAL instead of EACCES), just on top of all the
> confusion with slashes.

EINVAL in the library, sure.  EACCES is if you directly use the kernel
interface and pass it a name with any slashes in it.  The two interfaces
(library and kernel) aren't required to be identical.  Kernel is kept
simplest w/ no slashes, library provides POSIX compliance.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
