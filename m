Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVHQGs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVHQGs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 02:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbVHQGs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 02:48:26 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:59265 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750932AbVHQGs0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 02:48:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TMV75TR+HfM/70wKE9RN3HIcO/txkSAtGJJJZCgBRGRVMmPTrKDMrj1srpiFbxXZ8+D56R5VUtI2mi0EOLPqKELTZsmh+DIbOv17Frn0Fmvj5BkZVU4IYAj3fUSi8S3Z3RTQC+7VfIdTvH9z0RM8zY4CAl5HnORHiuko/21AP38=
Message-ID: <86802c4405081623483284908e@mail.gmail.com>
Date: Tue, 16 Aug 2005 23:48:25 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Jeff Mahoney <jeffm@suse.com>
Subject: Re: 2.6.12.3 clock drifting twice too fast (amd64)
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       jerome lacoste <jerome.lacoste@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marie-Helene Lacoste <manies@tele2.fr>
In-Reply-To: <430273F3.2000204@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a2cf1f6050816031011590972@mail.gmail.com>
	 <Pine.LNX.4.62.0508161103360.7101@schroedinger.engr.sgi.com>
	 <430273F3.2000204@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Me too. If use latest kernel mouse is dead.

By the way, did you solve the battery problem in Linux. "Can not read
battery status"

YH

On 8/16/05, Jeff Mahoney <jeffm@suse.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Christoph Lameter wrote:
> > On Tue, 16 Aug 2005, jerome lacoste wrote:
> >
> >>Installed stock 2.6.12.3 on a brand new amd64 box with an Asus extreme
> >>AX 300 SE/t mainboard.
> >>
> >>I remember seeing a message in the boot saying something along:
> >>
> >>  "cannot connect to hardware clock."
> >>
> >>And now I see that the time is changing too fast (about 2 seconds each second).
> >
> > The timer interrupt is probably called twice for some reason and therefore
> > time runs twice as fast. Try using HPET for interrupt timing.
> >
> >>I don't have visual on the boot sequence anymore (only remote access).
> >
> > Use serial console or netconsole. The boot information is logged. Try
> > dmesg.
> 
> I am seeing similar results on my Acer Ferrari 4000 (Turion64 ML-37). It
> does appear that time is running 2x normal time.
> 
> Booting with noapictimer cleared up the timing issues, though it did
> introduce some IRQ badness.
> 
> - -Jeff
> 
> - --
> Jeff Mahoney
> SuSE Labs
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.0 (GNU/Linux)
> 
> iD8DBQFDAnPzLPWxlyuTD7IRAuQ+AKCoK4Bvj9YaSxK1cYzK/LQUGcj2pQCgmBKK
> hGeSfGE+CvdNzqW3pN5LQq8=
> =wtra
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
