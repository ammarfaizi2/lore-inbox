Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbULPOdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbULPOdy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbULPOcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:32:47 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:2191 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262688AbULPOc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:32:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bSVMdxSjT86kxTXvhVyu+J4XGFBF9kdzmyVLWW0vcg6U0SREW0HuoVqJYhdob/ysPbyFutEHYQmVzBMAVXGMV20ZmFxyRvTnDQQrTqOXGhnldrOcllrkMmuNE8TgHi2FwNU8THESb8AOvnf1y4LivhJQUNhhN0qzxbI0ez1tK+c=
Message-ID: <58cb370e041216063264dbb83e@mail.gmail.com>
Date: Thu, 16 Dec 2004 15:32:26 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6.10-rc2+] ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
Cc: Rene Herman <rene.herman@keyaccess.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e04121606295fe384fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41B36021.5050600@keyaccess.nl>
	 <58cb370e04121313473057143b@mail.gmail.com>
	 <1103154772.3585.24.camel@localhost.localdomain>
	 <58cb370e04121606295fe384fc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004 15:29:19 +0100, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Wed, 15 Dec 2004 23:52:52 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Llu, 2004-12-13 at 21:47, Bartlomiej Zolnierkiewicz wrote:
> > > > I do need a way to force an 80c cable on this AMD756 (ATA66 max) board,
> > > > since the BIOS doesn't seem to be setting the cable bits correctly.
> > >
> > > Ugh, I checked AMD datasheets and AMD756 doesn't support host
> > > side cable detection.  Well, we can try doing disk side only for it.
> > > [ ATi and ITE (in -ac kernels) drivers are also doing this. ]
> >
> > That is probably a good change but not sufficient for things like
> > bladeservers where some vendors use short 40c cables which are within
> > specification but break drive side detection. Removing ata66 forcing
> > doesn't work because of these although perhaps it could be done using
> > subvendor ids so it is automatic ?
> 
> Yes, one of the aims of deprecating ata66 override was to see what can
> be done automatically.  The fewer special kernel parameters the better
> (w/o sacrificing functionality of course).

One thing I forgot - ata66 override alone ("idex=ata66") currently doesn't
help in the case you've described - it overrides host side only.

> > Right now I plan to keep ata66 overrides in -ac.
> 
> Fine but I'm not going to remove them soon (warning is a bit strong
> to help us gain more knowledge :), however it would be nice if somebody
> could move them from IDE core to specific host drivers.
> 
> Bartlomiej
