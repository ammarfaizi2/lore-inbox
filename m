Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUEOAXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUEOAXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUEOAQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:16:25 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:2688 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264649AbUENXtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:49:33 -0400
Date: Fri, 14 May 2004 05:25:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       rene.herman@keyaccess.nl, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-ID: <20040514032522.GA704@elf.ucw.cz>
References: <409F4944.4090501@keyaccess.nl> <200405102125.51947.bzolnier@elka.pw.edu.pl> <409FF068.30902@keyaccess.nl> <200405102352.24091.bzolnier@elka.pw.edu.pl> <20040510215626.6a5552f2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510215626.6a5552f2.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There is a problem with new 2.6 generic ->shutdown framework,
> >  it doesn't differentiate between reboot / halt and power_off.
> >  We may try to fix it or revert to 2.4 way of doing things if
> >  this is too big change for 2.6.
> 
> It's a bit grubby, but we could easily add a fourth state to
> `system_state': split SYSTEM_SHUTDOWN into SYSTEM_REBOOT and SYSTEM_HALT. 
> That would be a quite simple change.

I believe that we do not want to split that. These paths get pretty
little testing, and splitting testing effort even more could be pretty
bad.
								Pavel
-- 
When do you have heart between your knees?
