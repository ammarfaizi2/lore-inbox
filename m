Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWIEPir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWIEPir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWIEPir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:38:47 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:8358 "EHLO
	mail.lysator.liu.se") by vger.kernel.org with ESMTP id S965134AbWIEPip
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:38:45 -0400
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFAT truncate performance
References: <m3mz9e5sk1.fsf@isengard.friendlyfire.se>
	<1157468114.1435.216.camel@capoeira>
From: =?iso-8859-1?Q?Mattias_R=F6nnblom?= <hofors@lysator.liu.se>
Date: 05 Sep 2006 17:38:48 +0200
In-Reply-To: <1157468114.1435.216.camel@capoeira>
Message-ID: <m3fyf65nnb.fsf@isengard.friendlyfire.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> writes:

> On Tue, 2006-09-05 at 15:52, Mattias Rönnblom wrote:
> > Hi,
> > 
> > extending files by ftruncate(2) runs very slow on VFAT file
> > systems. On my USB harddisk w/ VFAT, it takes 14 seconds to extend an
> > empty file to 1 GB. On a memory stick, it takes well over 4 minutes.
> > 
> > My question is: is this problem on the conceptual level (ie there is
> > no way of extending files on FAT that doesn't involve many disk
> > operations) or is the current Linux fs driver suboptimal in this
> > respect?
> > 
> > The reason for asking is that I run Samba which service files on USB
> > devices (w/ VFAT for portability) to Windows XP clients. When copying
> > files to the Samba server, Microsoft SMB clients seem to extend the
> > file before actually starting to copy the data. This results in
> > sluggishness and timeouts when copying large files to VFAT
> > filesystems.
> 
> Is your USB stick mounted -o sync ? If that's the case, the truncate()
> and write() won't be merged so they will take twice as long. -o sync
> generally kills performance on USB sticks.
> 

No, 'async'.

Regards,
        Mattias

