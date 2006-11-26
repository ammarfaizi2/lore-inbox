Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756966AbWKZTwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966AbWKZTwK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 14:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756969AbWKZTwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 14:52:10 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:4359 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1756966AbWKZTwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 14:52:08 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64| perhaps duplicate bug report?
Date: Sun, 26 Nov 2006 19:52:11 +0000
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
References: <1164205742.13434.4.camel@localhost> <20061122152559.72efd379.akpm@osdl.org> <1164564469.9291.17.camel@localhost>
In-Reply-To: <1164564469.9291.17.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611261952.11063.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 November 2006 18:07, Kasper Sandberg wrote:
> On Wed, 2006-11-22 at 15:25 -0800, Andrew Morton wrote:
> > On Wed, 22 Nov 2006 15:29:02 +0100
> >
> > Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > it appears some sort of bug has gotten into .19, in regards to x86
> > > emulation on x86_64.
> > >
> > > i have only tested with >=rc5, thw folling, as an example, appears in
> > > dmesg:
> > > ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> > > arg(00221000) on /home/redeeman
> > > ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> > > arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
> >
> > Try
> >
> > 	echo 0 > /proc/sys/kernel/compat-log
> >
> > I don't _think_ we did anything to change the logging in there.  Which
> > kernel version were you using previously (the one which didn't do this)?
>
> it just struck me, that this may be the same bug Jesper Juhl has
> discovered (atleast the hardlock part), as i read that thread, it strike
> me that whenever i have hardlocks from this, its when i in wine runs
> stuff that uses basically all my ram, and MAY even touch my swap.

I see this same ioctl32 warning on a few apps running inside Wine, but I've 
not had any hard locks. On the contrary, everything works fine.

I guess it would be nice to know which ioctl it is that doesn't have a compat 
wrapper on x86-64, 82187201 is a bit cryptic.

HTH.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
