Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422626AbWJXViD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422626AbWJXViD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422629AbWJXViB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:38:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15540 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422626AbWJXViA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:38:00 -0400
Date: Tue, 24 Oct 2006 23:37:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061024213737.GD5662@elf.ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <20061024144446.GD11034@melbourne.sgi.com> <200610241730.00488.rjw@sisk.pl> <20061024163345.GG11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024163345.GG11034@melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Do you mean calling sys_sync() after the userspace has been frozen
> > may not be sufficient?
> 
> In most cases it probably is, but sys_sync() doesn't provide any
> guarantees that the filesystem is not being used or written to after
> it completes. Given that every so often I hear about an XFS filesystem
> that was corrupted by suspend, I don't think this is sufficient...

Userspace is frozen. There's noone that can write to the XFS
filesystem.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
