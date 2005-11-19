Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVKTVXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVKTVXL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVKTVWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:22:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59621 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750907AbVKTVWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:22:46 -0500
Date: Sat, 19 Nov 2005 23:43:32 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051119234331.GA1952@spitz.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <1132342590.25914.86.camel@localhost.localdomain> <20051118211847.GA3881@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118211847.GA3881@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > Just for info: If this goes in, Red Hat/Fedora kernels will fork
>  > > swsusp development, as this method just will not work there.
>  > > (We have a restricted /dev/mem that prevents writes to arbitary
>  > >  memory regions, as part of a patchset to prevent rootkits)
>  > 
>  > Perhaps it is trying to tell you that you should be using SELinux rules
>  > not kernel hacks for this purpose ?
> 
> I don't think selinux can give you the granularity to say
> "process can access this bit of the file only", at least not yet.
> 
> Even if that was capable however, it still doesn't solve the problem.
> Pavel's implementation wants to write to arbitary address spaces, which is
> what we're trying to prevent. The two are at odds with each other.

I do not think thats a security problem. By definition, suspending code
can change arbitrary things in memory -- it could just write image with
changes it desires, then resume from it. Whether this code is in kernel
or not, it has to be trusted.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

