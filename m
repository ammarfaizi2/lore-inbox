Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136938AbREKPMK>; Fri, 11 May 2001 11:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137153AbREKPMA>; Fri, 11 May 2001 11:12:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21840 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136938AbREKPLs>; Fri, 11 May 2001 11:11:48 -0400
Date: Fri, 11 May 2001 17:11:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mauelshagen@sistina.com, linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0 release decision
Message-ID: <20010511171124.M30355@athlon.random>
In-Reply-To: <20010511162745.B18341@sistina.com> <E14yDyI-0000yE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14yDyI-0000yE-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 11, 2001 at 03:32:46PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 03:32:46PM +0100, Alan Cox wrote:
> Please fix the binary incompatibility in the on disk format between the current
> code and your new release _before_ you do that. The last patches I was sent
> would have screwed every 64bit LVM user.

I just switched to the >=beta4 lvm IOP for all 64bit archs. The previous
one (the 2.4 mainline one) isn't feasible on the archs with 32bit
userspace and 64bit kernel (it uses long). The IOP didn't changed btw,
only the structures changed silenty.

> A new format is fine but import old ones properly. And if you do a new format

It's not a matter of the ondisk format, the on-disk format didn't
changed of course, it's the ioctl format between userspace and kernel 
that changed and the userspace only knows about 1 format. Once IOP
changes (or IOP breaks silenty as in this case) you have to upgrade
userspace with the current design.

Andrea
