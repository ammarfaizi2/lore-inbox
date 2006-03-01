Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWCASuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWCASuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWCASuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:50:54 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:51844 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932155AbWCASux
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:50:53 -0500
Date: Wed, 1 Mar 2006 11:50:51 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Lord <lkml@rtr.ca>, Matthias Andree <matthias.andree@gmx.de>,
       Douglas Gilbert <dougg@torque.net>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
Message-ID: <20060301185051.GC1598@parisc-linux.org>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net> <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org> <4405E8AA.1090803@rtr.ca> <Pine.LNX.4.64.0603011036110.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603011036110.22647@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 10:42:12AM -0800, Linus Torvalds wrote:
> I wouldn't expect it to. Most people use ATA for that, and it tends to 
> have lower limits than most SCSI HBA's (well, at least the old PATA), so 
> the change - if any - should at most change some of the sg.c limits to be 
> no less than what SG_IO has had on ATA forever.
> 
> Not that I expect people to have a SCSI CD/DVD drive anyway in this day 
> and age, so the sg.c changes probably won't show up at all.

My wife's last two laptops have both had 'SCSI' CD/DVD -- firewire on
the Vaio and SATA on the Lifebook.  Neither time have distros been
prepared to deal with such things ;-(

http://www.leog.net/fujp_forum/topic.asp?TOPIC_ID=9038 shows it's not
just my distro of choice that has problems with SATA ATAPI.
Unfortunately, the one-line change to enable that by default was too
late for 2.6.16, according to jgarzik.  I just hope all the distros
patch it.
