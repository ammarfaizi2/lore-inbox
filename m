Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUAGM10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 07:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUAGM10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 07:27:26 -0500
Received: from linuxhacker.ru ([217.76.32.60]:46498 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S266193AbUAGM1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 07:27:24 -0500
Date: Wed, 7 Jan 2004 14:27:27 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       mfedyk@matchmail.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       grev@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested
Message-ID: <20040107122727.GH415627@linuxhacker.ru>
References: <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <200401062135.i06LZAOY005429@car.linuxhacker.ru> <3FFB46B0.9060101@namesys.com> <20040106235335.GC415627@linuxhacker.ru> <3FFBD0B1.50909@namesys.com> <20040107100113.GE415627@linuxhacker.ru> <3FFBE6D3.7090701@namesys.com> <20040107120821.GG415627@linuxhacker.ru> <Pine.LNX.4.56.0401071312280.8981@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401071312280.8981@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 07, 2004 at 01:17:09PM +0100, Jesper Juhl wrote:
> > > >>can we get gcc to issue us a warning?  there might be other stuff
> > > >>lurking around also....
> > > >If you add -W switch to CFLAGS, you'd get A LOT of more warnings.
> > > >Also just reading manpage on gcc around description of that flag will
> > > >give you a list of options to individually turn on certain check types.
> > > >Also gcc 3.3 have this sort of " unsigned < 0 | unsigned > 0" checks on by
> > > >default, I think.
> > > Sigh, this means that not one member of our team bothered to compile
> > > with -W and cleanup things that were found?  Sad.  This is what happens
> > Well, I was doing these sorts of stuff and cleaning all stuff that I thought
> > was important enough.
> This is what I'm currently doing with all new -mm kernels. There's a lot
> of signed vs unsigned comparison all over the kernel as well as unsigned
> values being compared to negative values, missing initializers, and a lot
> of other minor stuff.

Well, some of this "minor" stuff was hiding major bugs, as I remember.

> I'm slowly trying to clean up what I find...

Great!

Bye,
    Oleg
