Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266261AbSKGBai>; Wed, 6 Nov 2002 20:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266264AbSKGBai>; Wed, 6 Nov 2002 20:30:38 -0500
Received: from pc132.utati.net ([216.143.22.132]:47233 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S266261AbSKGBai> convert rfc822-to-8bit; Wed, 6 Nov 2002 20:30:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Jens Axboe <axboe@suse.de>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Date: Wed, 6 Nov 2002 19:39:10 +0000
User-Agent: KMail/1.4.3
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021105165024.GJ13587@suse.de> <1036517201.5601.0.camel@localhost.localdomain> <20021105172617.GC1830@suse.de>
In-Reply-To: <20021105172617.GC1830@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211061939.10687.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 17:26, Jens Axboe wrote:
> On Tue, Nov 05 2002, Arjan van de Ven wrote:
> > On Tue, 2002-11-05 at 18:14, Jens Axboe wrote:
> > > axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 <
> > > .config 641:CONFIG_NFSD_V4=y
> > > axboe@burns:[.]linux-2.5-deadline-rbtree $ vi .config
> > > axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 <
> > > .config 641:CONFIG_NFSD_V4=n
> >
> > =n never worked...
>
> You're wrong, it's always worked. I've never used anything but that.
>
> > # CONFIG_NFSD_V4 is not set
>
> Come on, you really expect me to type the whole damn thing? That's
> silly.

Some of the #ifdef cases simply test whether the config option is defined.  
(Lots of #ifdef CONFIG_DEBUG_BLAH type stuff.)  Setting them to no counts as 
defining them, so it thinks it's a y.  (I remember cml2 hit that way back...)

Obviously, CONFIG_NFSD_V4 is not one of them...

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
