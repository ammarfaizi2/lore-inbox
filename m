Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265513AbUAGMUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 07:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUAGMUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 07:20:15 -0500
Received: from [193.138.115.2] ([193.138.115.2]:39688 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265513AbUAGMUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 07:20:10 -0500
Date: Wed, 7 Jan 2004 13:17:09 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Oleg Drokin <green@linuxhacker.ru>
cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       mfedyk@matchmail.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       grev@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related
 to sector_t being unsigned, advice requested
In-Reply-To: <20040107120821.GG415627@linuxhacker.ru>
Message-ID: <Pine.LNX.4.56.0401071312280.8981@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk>
 <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk>
 <20040106174650.GD1882@matchmail.com> <200401062135.i06LZAOY005429@car.linuxhacker.ru>
 <3FFB46B0.9060101@namesys.com> <20040106235335.GC415627@linuxhacker.ru>
 <3FFBD0B1.50909@namesys.com> <20040107100113.GE415627@linuxhacker.ru>
 <3FFBE6D3.7090701@namesys.com> <20040107120821.GG415627@linuxhacker.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Jan 2004, Oleg Drokin wrote:

> Hello!
>
> On Wed, Jan 07, 2004 at 02:00:35PM +0300, Hans Reiser wrote:
>
> > >>can we get gcc to issue us a warning?  there might be other stuff
> > >>lurking around also....
> > >If you add -W switch to CFLAGS, you'd get A LOT of more warnings.
> > >Also just reading manpage on gcc around description of that flag will
> > >give you a list of options to individually turn on certain check types.
> > >Also gcc 3.3 have this sort of " unsigned < 0 | unsigned > 0" checks on by
> > >default, I think.
> > Sigh, this means that not one member of our team bothered to compile
> > with -W and cleanup things that were found?  Sad.  This is what happens
>
> Well, I was doing these sorts of stuff and cleaning all stuff that I thought
> was important enough.
>

This is what I'm currently doing with all new -mm kernels. There's a lot
of signed vs unsigned comparison all over the kernel as well as unsigned
values being compared to negative values, missing initializers, and a lot
of other minor stuff.
I'm slowly trying to clean up what I find...
I'm most likely not going to be able to clean it /all/ up, and it's a slow
process for me, but I'll be posting patches whenever I think I've got
something cleaned up correctly.


- Jesper Juhl

