Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752173AbWCCEGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbWCCEGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbWCCEGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:06:46 -0500
Received: from smtp108.rog.mail.re2.yahoo.com ([68.142.225.206]:63054 "HELO
	smtp108.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1752173AbWCCEGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:06:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=Wp04CBFXh6Pmb85e9Yap3aCTKUsEG5pUSeh75yGpwiyOWjdTCFrlcCCSL7keoPLQgKMQaV3bBr3OivkMyFOoQ7popuFjMCYqcCOTT0vSaTwj9t8PnQcl3NP8ToJIOrW6CL8/e5fOn1nls8GRxGDWHuo0HGyQzftBE7m0ZNCPdPs=  ;
Subject: [Fwd: Re: [2.6 patch] make UNIX a bool]
From: "James C. Georgas" <jgeorgas@rogers.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 02 Mar 2006 23:06:56 -0500
Message-Id: <1141358816.3582.18.camel@Rainsong.home>
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
> > > > > It does also matter in the kernel image size case, since you
have to put
> > > > > enough modules to the other medium for having a effect bigger
than the
> > > > > kernel image size increase from setting CONFIG_MODULES=y.
> > > >
> > > > That's not very difficult considering the large number of
modules that's
> > > > out there that a system may wish to use.
> > > >...
> > >
> > > This might be true for full-blown desktop systems - but these do
not
> > > tend to be the systems where kernel image size matters that much.
> > > Smaller kernel image size might be an issue e.g. for distribution
> > > kernels, but in a much less pressing way.
> > >
> > > The systems where kernel image size really matters are systems
with few
> > > modules where you know in advance which modules you might need. I
played
> > > a bit with the ARM defconfigs, and if you consider that you can't
build
> > > the filesystem for accessing your modules modular I haven't found
any
> > > where making everything modular would have given a real kernel
image
> > > size gain compared to the CONFIG_MODULES=n case.
> > >
> > 
> > I believe the basic question is this: What do we win by making
> > CONFIG_UNIX a bool?
> >...
> 
> We do not have to export symbols we don't want to export to modules
but 
> needed by CONFIG_UNIX.

Sorry, I must just be dense, or something.

Is not the only difference between a modular driver and a built in
driver supposed to be the initialization and cleanup functions?

I don't see why you would have to expose any additional symbols, over
and above the existing required symbols, to load your module.

-- 
James C. Georgas <jgeorgas@rogers.com>

