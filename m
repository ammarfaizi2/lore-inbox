Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVFPNjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVFPNjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 09:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVFPNjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 09:39:09 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:17087 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261630AbVFPNjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 09:39:05 -0400
Date: Thu, 16 Jun 2005 09:39:04 -0400
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: mru@inprovide.com, Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050616133904.GU23488@csclub.uwaterloo.ca>
References: <f192987705061303383f77c10c@mail.gmail.com> <yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm> <200506150454.11532.pmcfarland@downeast.net> <42AFF184.2030209@poczta.fm> <yw1xd5qo2bzd.fsf@ford.inprovide.com> <42B04090.7050703@poczta.fm> <20050615212825.GS23621@csclub.uwaterloo.ca> <42B0BAF5.106@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B0BAF5.106@poczta.fm>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 01:34:13AM +0200, Lukasz Stelmach wrote:
> That's why UTF-8 is suggested. UTF-8 has been developed to "fool" the
> software that need not to be aware of unicodeness of the text it manages
> to handle it without any hickups *and* to store in the text information
> about multibyte characters.What characters exactly you do mean? NULL?
> There is no NULL byte in any UTF-8 string except the one which
> terminates it.

That is true.  UTF-8 wouldn't cause any more problems than ascii already
does, such as some filesystems not allowing : and * in filenames among
other characters.

> Yes, it uses unicode. And dos codepages in short ones. To prove this
> take a vfat floppy and mount it. touch(1) a file on it that has some
> non latin1 characters. Unmount the floppy then do dd if=/dev/fd0
> of=/tmp/floppy bs=1024 count=512. While it's done take some hex
> editor/viewer and seek the latin1-complaint part of the filename
> in the floppy file (search for uppercase string). Righ above the short
> filename you'll find multibyte long one.

Well at least that seems like they did something right when they
extended FAT with VFAT.  Doesn't make FAT a good filesystem, but it does
make the filename extension pretty nice, much as it is an ugly hack too.

> I've tried cd packet writing with UDF and it gives insane overhead of
> about 20%. What metadata you'd like to store for example on your
> flashdrive or a floppy disk?

The constant rewriting of the same sectors that store the FAT is really
bad for some types of flash and other removeably media (like DVD-RAM).

I hadn't noticed any big overhead in UDF, although packet writing may
add some overhead itself (I never used packet writing).

Len Sorensen
