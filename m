Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265564AbUABTSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265570AbUABTSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:18:33 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:26792 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265564AbUABTSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:18:31 -0500
Date: Fri, 2 Jan 2004 20:18:05 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Libor Vanek <libor@conet.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040102191805.GA12905@wohnheim.fh-wedel.de>
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il> <3FF59073.3060305@conet.cz> <20040102160020.A24026@infradead.org> <20040102163552.GD31489@wohnheim.fh-wedel.de> <3FF5A36A.5070501@conet.cz> <20040102180431.GB6577@wohnheim.fh-wedel.de> <3FF5BF68.8060303@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FF5BF68.8060303@conet.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 January 2004 19:58:48 +0100, Libor Vanek wrote:
> On Fri, Jan 02, 2004 at 07:04:31PM +0100, Jörn Engel wrote:
> >On Fri, 2 January 2004 17:59:22 +0100, Libor Vanek wrote:
> >> 
> >> This is also something (but just a bit) different - I don't need "change 
> >> notification" but "pre-change notification" ;)
> >
> >"Vor dem Spiel ist nach dem Spiel" -- Sepp Herberger
> >
> >Except for exactly two cases, pre-change and post-change and the same,
> >just off-by-one.  So you would need a bootup/mount/whenever special
> >case now, is that a big problem?
> 
> Probably my english is bad but I don't understand what are you trying to 
> say (except the german part ;-))
> A bit more about pre/post-change (if this is what are you trying to say) - 
> I need allways pre-change because after file is changed I can no longer get 
> original (pre-change) version of file which I need for snapshot.

If you take a snapshot on every change within your scope, it doesn't
really matter whether you do it before or after the change.  Before
change n is just after change n-1.  All you have to do is take another
snapshot before the first change, that is the special case.

If you take snapshots just once in a blue moon, this obviously doesn't
work.  But I wonder if that approach would make sense anyway, as
incremental snapshots are just so much nicer.  Actually, I've once written
a Pascal program to do just that, for some stupid university credit.
It doesn't have the proper kernel hooks and is the wrong language, but
it does the incremental snapshot.  Documentation is in German, but if
you are interested, I will try to find an electronic copy.

Actually, with userspace notification in place, you could even get
this with just cvs.  Whenever a file is changed, commit.  cvs add on
creation, etc.  Yes, it sucks, but implementation simplicity has it's
own beauty and it would only take a few minutes. :)

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
