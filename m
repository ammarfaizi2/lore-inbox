Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbUKGIcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUKGIcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 03:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbUKGIcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 03:32:23 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:61877 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261558AbUKGIcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 03:32:16 -0500
Date: Sun, 07 Nov 2004 17:28:38 +0900 (JST)
Message-Id: <20041107.172838.74752953.taka@valinux.co.jp>
To: liudeyan@gmail.com
Cc: jimtabor@adsl-64-217-116-74.dsl.hstntx.swbell.net,
       linux-kernel@vger.kernel.org, kaz@earth.email.ne.jp
Subject: Re: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar
 file)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <aad1205e041106233274e78428@mail.gmail.com>
References: <aad1205e0411062306690c21f8@mail.gmail.com>
	<418DCB2F.2030303@adsl-64-217-116-74.dsl.hstntx.swbell.net>
	<aad1205e041106233274e78428@mail.gmail.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andyliu,

Amazing that you continue our work!
Where did you get the code?

Several years ago, we - Kazuto and I -  made the filesystem
just for magazine readers. We designed it as simple as we could,
as it was a sample filesystem to explain about the design and the
implementation of linux filesystems.

I guess there may remain many things to do about it:
    - To support tar.gz and tar.bz2. I guess this should be done in
      a compression device, which might be md layers or a loop device
      itself.
    - It may be better if you can make tarent objects free-able
      while the filesystem is mounted.
    - It may be possible to implement append mode.
      A new file can be appended to the filesystem.

We're expecting you to do a good job.

> oh,sorry.it's a readonly filesystem now.i will try to make it writeable.
> but i use tar file as loop device.
> 
> by the way,if we mount an iso file it's a readonly filesystem too.
> i think maybe we should do something on the loop device to support
> this kind of write.
> 
> On Sun, 07 Nov 2004 07:13:51 +0000, James Tabor
> <jimtabor@adsl-64-217-116-74.dsl.hstntx.swbell.net> wrote:
> > andyliu wrote:
> > 
> > 
> > > hi
> > >
> > >   let's think about the way we access the file which contained in a tar file
> > > may we can untar the whole thing and we find the file we want to access
> > > or we can use the t option with tar to list all the files in the tar
> > > and then untar the only one file we want to access.
> > >
> > >   but with the help of the tarfs,we can mount a tar file to some dir and access
> > > it easily and quickly.it's like the tarfs in mc.
> > >
> > >  just mount -t tarfs tarfile.tar /dir/to/mnt -o loop
> > > then access the files easily.
> > >
> > > it was writen by Kazuto Miyoshi (kaz@earth.email.ne.jp) Hirokazu
> > > Takahashi (h-takaha@mub.biglobe.ne.jp) for linux 2.4.0

This address is no longer usable.

> > > and i make it work for linux 2.6.0. now a patch for linux 2.6.10-rc1-mm3
> > >
> > > the patch is to big to send it as plain text, so i can only send it as
> > > an attachment
> > >
> > > thanks
> > > 
> > Wow! How cool is this! Can you copy files into a tarfs subsystem? Just like
> > we do with iso's?
> > Cool,
> > James

Thanks,
Hirokazu Takahashi.

