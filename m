Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbUAMQ0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 11:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUAMQ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 11:26:15 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7916 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264356AbUAMQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 11:26:14 -0500
Date: Tue, 13 Jan 2004 17:26:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       mfedyk@matchmail.com, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested
Message-ID: <20040113162605.GM9677@fs.tum.de>
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <200401062135.i06LZAOY005429@car.linuxhacker.ru> <3FFB46B0.9060101@namesys.com> <20040106235335.GC415627@linuxhacker.ru> <3FFBD0B1.50909@namesys.com> <20040107100113.GE415627@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107100113.GE415627@linuxhacker.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 12:01:13PM +0200, Oleg Drokin wrote:
> Hello!
> 
> On Wed, Jan 07, 2004 at 12:26:09PM +0300, Hans Reiser wrote:
> > >As for why gcc is finding this, but scripts (e.g. smatch) do not is because
> > >scripts generally know nothing about variable types, so they cannot tell
> > >this comparison was always false (and since gcc can do this for long time
> > >already, there is no point in implementing it in scripts anyway).
> > can we get gcc to issue us a warning?  there might be other stuff 
> > lurking around also....
> 
> If you add -W switch to CFLAGS, you'd get A LOT of more warnings.
> Also just reading manpage on gcc around description of that flag will
> give you a list of options to individually turn on certain check types.
> Also gcc 3.3 have this sort of " unsigned < 0 | unsigned > 0" checks on by
> default, I think.

IIRC this was only in prerelease versions of gcc 3.3 (including one SuSE
ships). For released version of gcc you need -Wsign-compare.

> Bye,
>     Oleg

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

