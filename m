Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288959AbSANUX4>; Mon, 14 Jan 2002 15:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSANUXC>; Mon, 14 Jan 2002 15:23:02 -0500
Received: from mail004.syd.optusnet.com.au ([203.2.75.228]:58047 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S289011AbSANUVs>; Mon, 14 Jan 2002 15:21:48 -0500
Date: Tue, 15 Jan 2002 07:21:22 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, Oleg Drokin <green@namesys.com>,
        reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        ewald.peiszer@gmx.at, matthias.andree@stud.uni-dortmund.de
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
Message-ID: <20020115072122.I20639@gnu.org>
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org> <20020114095013.A4760@namesys.com> <3C42BE0E.2090902@namesys.com> <20020114143650.D828@namesys.com> <20020114104242.M26688@lynx.adilger.int> <3C43357D.40600@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C43357D.40600@namesys.com>; from reiser@namesys.com on Mon, Jan 14, 2002 at 10:46:05PM +0300
X-Accept-Language: en,pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 10:46:05PM +0300, Hans Reiser wrote:
> >Hmm, I could have sworn I submitted patches already which did both of these
> >things.  In general, it is perfectly safe to zero the bootsector of a
> >partition when you mkfs it (mke2fs has been doing this for a long time).
> >If you mkfs your boot partition (and zap the bootblock) you would have to
> >run LILO on it anyways after they install a new kernel, because the
> >location of the kernel would change.
>
> Can the kernel be in a different partition from the boot partition?  If 
> so, it is not safe, yes?

Correct.

OTOH, it seems sane to reinstall lilo anyway in such situations.

OTOH2, Parted only erases signatures, so it won't break LILO.
OTOH3, this requires parted knowing about different fs types
(which it does, to a large extent).

Andrew

