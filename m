Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVHWOEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVHWOEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 10:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVHWOEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 10:04:16 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:54489 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751016AbVHWOEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 10:04:16 -0400
Date: Tue, 23 Aug 2005 10:04:14 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Machida, Hiroyuki" <machida@sm.sony.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Posix file attribute support on VFAT (take #2)
Message-ID: <20050823140414.GA28578@csclub.uwaterloo.ca>
References: <43023957.1020909@sm.sony.co.jp> <20050816212531.GA2479@infradead.org> <20050822114629.GA29046@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822114629.GA29046@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 01:46:29PM +0200, Pavel Machek wrote:
> Unfortunately, it makes sense. If you have compact flash card, you
> really want to have VFAT there, so that it is a) compatible with
> windows and b) so that you don't kill the hardware.

VFAT is plenty good at killing hardware.  It's a terrible filesystem for
flash cards (if they don't do their own wear leveling properly).  Most
of the linux filesystems may not be any better but they are also no
worse.  Windows compatibility is completely irrelevant if the card is
being used as your root filesystem since any extensions you make to vfat
wouldn't be understood by windows anyhow, so at best it makes a mess of
it.

> I guess being able to use CF card for root filesystem is usefull,
> too....

I run ext3 on CF and so far, no problems.  I run with noatime and try to
avoid writing in general as much as possible.  VFAT would be crap since,
well, I run linux on the system.

Len Sorensen
