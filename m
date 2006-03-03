Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWCCE2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWCCE2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWCCE2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:28:13 -0500
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:32083 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750748AbWCCE2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:28:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=1vCp3ARBSsp/ymAfo3BBctF5IoK/noWyZ+xYRclFw0Qfusz6yBAUT92k0m7sxBmjeM3qq0xl0c1Fjz1eH1bUymDucakdYK3yHAdFdFViY9tEV7EvbS3RPWdIZayiJP553mWHfkaABp7pEEbf7AM+9af1ymXYdnBCJv1UmXLxJUQ=  ;
Subject: Re: [2.6 patch] make UNIX a bool
From: "James C. Georgas" <jgeorgas@rogers.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20060302203245.GD9295@stusta.de>
References: <20060301175852.GA4708@stusta.de>
	 <E1FEcfG-000486-00@gondolin.me.apana.org.au>
	 <20060302173840.GB9295@stusta.de>
	 <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com>
	 <20060302203245.GD9295@stusta.de>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 23:28:26 -0500
Message-Id: <1141360106.3582.27.camel@Rainsong.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-03 at 21:32 +0100, Adrian Bunk wrote:
> On Thu, Mar 02, 2006 at 09:28:15PM +0100, Jesper Juhl wrote:
> > On 3/2/06, Adrian Bunk <bunk@stusta.de> wrote:
> > > On Thu, Mar 02, 2006 at 12:31:34PM +1100, Herbert Xu wrote:
> > > > Adrian Bunk <bunk@stusta.de> wrote:
> > > > >
> > > > > It does also matter in the kernel image size case, since you have to put
> > > > > enough modules to the other medium for having a effect bigger than the
> > > > > kernel image size increase from setting CONFIG_MODULES=y.
> > > >
> > > > That's not very difficult considering the large number of modules that's
> > > > out there that a system may wish to use.
> > > >...
> > >
> > > This might be true for full-blown desktop systems - but these do not
> > > tend to be the systems where kernel image size matters that much.
> > > Smaller kernel image size might be an issue e.g. for distribution
> > > kernels, but in a much less pressing way.
> > >
> > > The systems where kernel image size really matters are systems with few
> > > modules where you know in advance which modules you might need. I played
> > > a bit with the ARM defconfigs, and if you consider that you can't build
> > > the filesystem for accessing your modules modular I haven't found any
> > > where making everything modular would have given a real kernel image
> > > size gain compared to the CONFIG_MODULES=n case.
> > >
> > 
> > I believe the basic question is this: What do we win by making
> > CONFIG_UNIX a bool?
> >...
> 
> We do not have to export symbols we don't want to export to modules but 
> needed by CONFIG_UNIX.
> 
> > Jesper Juhl <jesper.juhl@gmail.com>
> 
> cu
> Adrian
> 

Sorry, I must just be dense, or something.

Is not the only difference between a modular driver and a built in
driver supposed to be the initialization and cleanup functions?

I don't see why you would have to expose any additional symbols, over
and above the existing required symbols, to load your module.

-- 
James C. Georgas <jgeorgas@rogers.com>

