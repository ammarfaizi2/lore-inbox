Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVCVCrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVCVCrB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVCVCqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:46:53 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:5068 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262208AbVCVCli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:41:38 -0500
Subject: Re: [PATCH][2/2] SquashFS
From: Josh Boyer <jdub@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050321224937.GQ1390@elf.ucw.cz>
References: <20050314170653.1ed105eb.akpm@osdl.org>
	 <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk>
	 <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com>
	 <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk>
	 <20050321190044.GD1390@elf.ucw.cz> <423F0C67.6000006@lougher.demon.co.uk>
	 <20050321224937.GQ1390@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 20:41:05 -0600
Message-Id: <1111459265.20190.15.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 23:49 +0100, Pavel Machek wrote:
> Hi!
> 
> > >Perhaps squashfs is good enough improvement over cramfs... But I'd
> > >like those 4Gb limits to go away.
> > 
> > So would I.  But it is a totally groundless reason to refuse kernel 
> > submission because of that, Squashfs users are quite happily using it 
> > with such a "terrible" limitation.  I'm asking for Squashfs to be put in 
> > the kernel _now_ because users are asking me to do it _now_.  If it 
> 
> Putting it into kernel because users want it is... not a good
> reason. You should put it there if it is right thing to do. I believe
> you should address those endianness issues and drop V1 support. If
> breaking 4GB limit does not involve on-disk format change, it may be
> okay to merge. After code is merged, doing format changes will be
> hard...

No, it's not.  If the on disk format needs to change, it's usually a
sign that the code has changed enough to warrant a version change.  And
there are examples of that all over the kernel.  Ext3, JFFS2, and
Reiser4, are just a few.  The SquashFS code is very useful as it is
today.  There is no reason to delay it's inclusion because it has a 4GiB
limitation.

And while I agree that something should be included in the kernel for
the "right" reasons, you still have to listen to users.  In this case,
those users range from the embedded world to actual distributions.

This is a useful, stable, and _maintained_ filesystem and I'm a bit
surprised that there is this much resistance to it's inclusion.

josh

