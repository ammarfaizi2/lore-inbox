Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbWFCHJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWFCHJY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 03:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWFCHJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 03:09:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25619 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932593AbWFCHJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 03:09:23 -0400
Date: Tue, 30 May 2006 15:29:26 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Bisects that are neither good nor bad
Message-ID: <20060530152926.GA4103@ucw.cz>
References: <20060528140238.2c25a805.dickson@permanentmail.com> <20060528140854.34ddec2a.paul@permanentmail.com> <200605282324.13431.rjw@sisk.pl> <200605282324.13431.rjw@sisk.pl> <20060528213414.GC5741@redhat.com> <r6u079rrik.fsf@skye.ra.phy.cam.ac.uk> <20060529145255.GB32274@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529145255.GB32274@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > I think I've seen the same problem on one of my (similar spec) laptops.
>  > > Serial console was useless. On resume, there's a short spew of garbage
>  > > (just like if the baud rate were misconfigured) over serial before it
>  > > locks up completely.
>  > 
>  > <http://bugzilla.kernel.org/show_bug.cgi?id=4270> discusses a similar
>  > problem on a couple of machines.  In my resume script (for a TP 600X),
>  > I have to restore the serial console with
>  > 
>  >   setserial -a /dev/ttyS0
>  > 
>  > Until that magic executes, garbage characters (like modem noise)
>  > appear across the serial console.
> 
> With the resume failure I'm seeing, we don't get back to userspace
> to run anything like this. It goes bang long before that.
> 
> The SATA fix Mark proposed also didn't improve the situation for me :-/

If setserial -a is needed.. it means that someone really needs to fix
suspend/resume support for serial... do it on working machine to
enable debugging of broken ones...

(But x32 has no serials, so I'm unlikely to code it...)
-- 
Thanks for all the (sleeping) penguins.
