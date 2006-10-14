Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752120AbWJNIcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbWJNIcc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 04:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWJNIcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 04:32:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44958 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752120AbWJNIcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 04:32:32 -0400
Date: Sat, 14 Oct 2006 10:32:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp APIC oopsen (was Re: swsusp ooms)
Message-ID: <20061014083227.GA3868@elf.ucw.cz>
References: <20061009213359.7f2806b6.akpm@osdl.org> <200610132231.08643.rjw@sisk.pl> <20061013140000.329e8854.akpm@osdl.org> <200610132307.47162.rjw@sisk.pl> <20061014002504.1ab10ee9.akpm@osdl.org> <20061014004046.670ddd76.akpm@osdl.org> <20061014082237.GA3818@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014082237.GA3818@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-10-14 10:22:37, Pavel Machek wrote:
> Hi!
> 
> (cc-ed to public list)
> 
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > and I'm not having much luck.  See 
> > > 
> > > http://userweb.kernel.org/~akpm/s5000340.jpg and
> > > http://userweb.kernel.org/~akpm/s5000339.jpg
> > 
> > Running an UP kernel and disabling local APIC avoided the oopses and
> > allowed me to confirm that it was leaking.  whoops.
> 
> I wonder why everyone but me sees those APIC problems?
> 
> Anyway, there's one more problem in -rc1: boot order changed, and (at
> least with paralel boot options), swsusp gets initialized *after*
> swsusp => bad, but should be easy to fix.

Sorry, I meant:

"sata is initialized *after* swsusp => bad".
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
