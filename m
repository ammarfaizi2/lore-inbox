Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWFYDTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWFYDTw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 23:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWFYDTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 23:19:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:36549 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751366AbWFYDTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 23:19:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=puauarIusP3XZq/5uRXG7YaCAsJM9VEKrtHVLlvFYQPdAEkS0o135zn1YKil2MuwxOcZjUGp8HveNZnW90H0tfW7ul7NBHd9XcnlONT5q965gBreL7+tYV1AhuthEHwrC8ZD38wj0zwXVMZHKwewuXR+d1MlWOz7W/QjP1gwQ4k=
Message-ID: <625fc13d0606242019l2ee7ca29w178896d7355b9302@mail.gmail.com>
Date: Sat, 24 Jun 2006 22:19:50 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Troy Benjegerdes" <hozer@hozed.org>
Subject: Re: PATCH: Change in-kernel afs client filesystem name to 'kafs'
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060624181900.GP5040@narn.hozed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060624004154.GL5040@narn.hozed.org>
	 <20060624133703.GB15734@infradead.org>
	 <20060624181900.GP5040@narn.hozed.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/06, Troy Benjegerdes <hozer@hozed.org> wrote:
> On Sat, Jun 24, 2006 at 02:37:03PM +0100, Christoph Hellwig wrote:
> > On Fri, Jun 23, 2006 at 07:41:59PM -0500, Troy Benjegerdes wrote:
> > > This patch changes the in-kernel AFS client filesystem name to 'kafs',
> > > as well as allowing the AFS cache manager port to be set as a module
> > > parameter. This is usefull for having a system boot with the root
> > > filesystem on afs with the kernel AFS client, while still having the
> > > option of loading the OpenAFS kernel module for use as a read-write
> > > filesystem later.
> >
> > NACK.  OpenAFS isn't even legal to load into the kernel, we shouldn't
> > support it.  Better help making the kernel afs client fully features
> > than wasting your time on this.
>
> So, you are telling me that even though OpenAFS has a license
> substationally similiar in intent to the GPLv2, that it's not legal to
> load into the kernel, even though the OpenAFS code predates the Linux
> kernel by about 5 years? Are you going to personally sue me if I put up
> an initramfs image with the OpenAFS kernel module in it?

I doubt anyone would waste their time.

Btw, release date has nothing to do with licensing issues.  The
original BSD license was around before the GPL, and yet they were
incompatible.

>
> My home directory is in AFS. And if you want me to help make the kernel
> AFS client full-featured, I need to have both kAFS and OpenAFS loaded
> and mounted at the same time. So quit bitching about OpenAFS and get out of
> my way so I can work on kAFS.

Nobody is in your way.  If you truly want to improve kAFS to the point
where it is usable, then by all means do so.  There are many people
that would thank you.

However, I hope that you would agree that the end goal is to have kAFS
be a drop in replacement such that it can be used inter-changeably
with other AFS implementations.  Given that, integrating a patch the
changes the filesystem type which will later be reverted just is
silly.

There is nothing preventing you from doing this in your local tree
while you work on kAFS.  Pushing it to the mainline kernel is just
wrong though.  The fact your local setup requires you have both kAFS
and OpenAFS loaded at the same time is not reason enough to change it
in mainline.

josh
