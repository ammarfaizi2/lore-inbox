Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUIIPEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUIIPEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUIIPEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:04:36 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:21479 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S265410AbUIIPEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:04:33 -0400
Date: Thu, 9 Sep 2004 17:04:33 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve French <smfltc@us.ibm.com>
Subject: Re: [PATCH 4/4] copyfile: copyfile
Message-ID: <20040909150432.GA15888@MAIL.13thfloor.at>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Steve French <smfltc@us.ibm.com>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de> <20040907121118.GA27297@wohnheim.fh-wedel.de> <20040907121235.GB27297@wohnheim.fh-wedel.de> <20040907121520.GC27297@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org> <20040907145118.GA29993@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0409070756410.2299@ppc970.osdl.org> <20040907152118.GA30396@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040907152118.GA30396@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 05:21:18PM +0200, Jörn Engel wrote:
> On Tue, 7 September 2004 07:59:11 -0700, Linus Torvalds wrote:
> > On Tue, 7 Sep 2004, Jörn Engel wrote:
> > > 
> > > Does that mean that you're ok with the first three patches?
> > 
> > No, it means that they weren't fundamentally flawed..
> 
> It's a start...
> 
> > Actually, the 4kB batching one was - if you only max out to using 4kB at a 
> > time, sendfile() is kind of pointless, because then it will never do 
> > multi-page copies in the first place, and all the complexity at a lower 
> > level is worthless..
> 
> Give me a better number.  16k?  1M?  Or would it not be fundamentally
> flawed if the unit was seconds, instead of bytes?  That makes a lot
> more sense, since a floppy and a Ultra320 RAID array differ slightly
> in speed and it's response time the users actually care about.

maybe the 'block/buffer' size could be passed with the
syscall (maybe with a kernel default), allowing dumb tools 
to use a fixed value and smart ones, exactly what the user 
desires ...

best,
Herbert

> Jörn
> 
> -- 
> /* Keep these two variables together */
> int bar;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
