Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWFXMDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWFXMDF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 08:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWFXMDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 08:03:05 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:29016 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964782AbWFXMDD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 08:03:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CzIuVEuyhc+QGNSDdh50291tRIWB6g6dF9A+hBwUXEvyEeFPU7WijNwtS485JwkIDE0Eq4xMkAlYX1Rp4SK1pUCnf3cPVfTYmVBxw25XDygoqjqpIjg9zP60su02A1SAGHqlEEAVKlMuuqegqErAL5YWK4NUWjba2caBGCSkQf8=
Message-ID: <b8bf37780606240503s4713283eo2b8aa43513751da9@mail.gmail.com>
Date: Sat, 24 Jun 2006 08:03:03 -0400
From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: [ck] Re: [PATCH] fcache: a remapping boot cache
Cc: James <iphitus@gmail.com>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060624110959.GQ4083@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060515091806.GA4110@suse.de> <20060515101019.GA4068@suse.de>
	 <20060516074628.GA16317@suse.de>
	 <4d8e3fd30605301438k457f6242x1df64df9bab7f8f1@mail.gmail.com>
	 <20060531061234.GC29535@suse.de>
	 <1e1a7e1b0606232044x11136be5p332716b757ecd537@mail.gmail.com>
	 <20060624110959.GQ4083@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/06, Jens Axboe <axboe@suse.de> wrote:
> On Sat, Jun 24 2006, James wrote:
> > Set this up on my laptop yesterday with some awesome results. I'm
> > using 2.6.17-ck1 which has v2.1.
> >
> > Heres some bootcharts, before, after, and a prime run.
> >
> > http://archlinux.org/~james/normal.png
> > http://archlinux.org/~james/fs-fcache.png
> > http://archlinux.org/~james/fs-fcache-prime.png
> >
> > Repeated boots show about the same 6 second improvement, 32 down to 26
> > seconds. Looking at the slowdowns in the fs-fcache run, most are due
> > to cpu load, waiting on network or, modprobe, and not disk access. X
> > now starts nearly instantaneously.
> >
> > As an experiment, I primed my cache right through to logging into my
> > desktop environment. It was so effective, that now when I login, the
> > GNOME splash screen only flickers onto the screen briefly, and the
> > panels appear almost instantly. This is a big improvment over without
> > fcache, where you'd see each component of GNOME being loaded on the
> > splash screen, nautilus, metacity, and the panels would take quite a
> > bit of time to render and load all their applets.
> >
> > Impressive work, I hope to see it broadened to other filesystems,
> > improved and merged to vanilla soon because it has clear improvements.
>
> Thanks for giving it a spin! I have plans to implement some improvements
> on monday that will speed it up even more, I hope I can talk you into
> retesting it then. Basically it make sure we always get full speed out
> of the drive by extending the 4kb reads with a sliding window cache.
> That will help both drive efficiency, and also speed up the cases where
> sub sequent boots differ just a little bit from the primed boot (often
> the case with parallel init scripts). It should win you a few seconds
> more in total, would be my guess.
>
> I hope to be able to extend it to xfs and reiser in the very near future
> as well, should not be hard to do.

Impressive good work, Jens!

Do you have any distribution in contact with you already?

Thank you so much, I look forward to test it on xfs.

Best regards,
-- 
[]s,
André Goddard
