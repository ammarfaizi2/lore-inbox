Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271106AbVBEWhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271106AbVBEWhu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 17:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVBEWhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 17:37:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:15342 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S271451AbVBEWhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 17:37:40 -0500
Subject: Re: 2.6.11-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Neakums <sneakums@zork.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <6u3bwbffjt.fsf@zork.zork.net>
References: <20050204103350.241a907a.akpm@osdl.org>
	 <6ud5vgezqx.fsf@zork.zork.net> <1107561472.2363.125.camel@gaston>
	 <6u7jlng9b0.fsf@zork.zork.net> <1107562609.2363.134.camel@gaston>
	 <58cb370e05020416546e0d6b0e@mail.gmail.com>  <6u3bwbffjt.fsf@zork.zork.net>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 09:35:43 +1100
Message-Id: <1107642944.30270.20.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-05 at 10:48 +0000, Sean Neakums wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:
> 
> > On Sat, 05 Feb 2005 11:16:49 +1100, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> >> 
> >> > I tried it two or three times, same result each time.  I'll give it a
> >> > lash with USB disabled.
> >> 
> >> Also, can you try editing arch/ppc/syslib/open_pic.c, in function
> >> openpic_resume(), comment out the call to openpic_reset() and let me
> >> know if that helps...
> >
> > Well, maybe I'm to blame this time...
> >
> > I've introduced bug in ATAPI Power Management handling,
> > idedisk_pm_idle shouldn't be done for ATAPI devices.
> >
> > Sorry for that, fix attached.
> 
> With this patch alone and with USB configured out, suspend/resume works.

Confirmation from paulus, there is indeed a problem with IDE that is
fixed by Bart's patch.

There are still issues with USB though... this one, and paul's one, I've
forwarded Sean report to David, we'll see what we can find...

Ben.


