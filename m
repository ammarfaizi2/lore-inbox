Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266235AbUAGRsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUAGRsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:48:08 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:34450 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S266235AbUAGRqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:46:34 -0500
Date: Wed, 7 Jan 2004 09:45:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested
Message-ID: <20040107174557.GJ1882@matchmail.com>
Mail-Followup-To: Oleg Drokin <green@linuxhacker.ru>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
	Jesper Juhl <juhl-lkml@dif.dk>
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <200401062135.i06LZAOY005429@car.linuxhacker.ru> <3FFB46B0.9060101@namesys.com> <20040106235335.GC415627@linuxhacker.ru> <3FFBD0B1.50909@namesys.com> <20040107100113.GE415627@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107100113.GE415627@linuxhacker.ru>
User-Agent: Mutt/1.5.4i
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

That was suse using a version of gcc pulled from cvs, not a released version
of 3.3.x IIRC.
