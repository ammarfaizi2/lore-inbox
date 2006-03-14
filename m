Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWCNOMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWCNOMB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWCNOMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:12:00 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:43368 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751269AbWCNOL7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:11:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uUjpVClT0U7I/41sQS69ghzYvednk/78W195JSuitkudLBhM20i9hvrWdbzqPkaB5Pkl+EHJ+f0jSUojAoPjBHhofPDf1Csuh5FMXG41LywAXiHqmgyqi0NCu6DNN3U2JHLYleG4wj08UB8m8p3/fIC8A/pDE12CylzEQgl2aUQ=
Message-ID: <436c596f0603140611n74f37ef8xbf1f9d5cac5cf056@mail.gmail.com>
Date: Tue, 14 Mar 2006 11:11:58 -0300
From: j4K3xBl4sT3r <jakexblaster@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How do I get the ext3 driver to shut up?
In-Reply-To: <20060313193027.b0eae48e.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603132218.39511.rob@landley.net>
	 <20060313193027.b0eae48e.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like those test suits... (PASS, FAIL...)

On 3/14/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Mon, 13 Mar 2006 22:18:39 -0500 Rob Landley wrote:
>
> > I'm making a test suite for busybox mount, which does filesystem autodetection
> > the easy way (try all the ones in /etc/filesystems and /proc/filesystems
> > until one of them succeeds).  My test code is creating and mounting vfat and
> > ext2 filesystems.
> >
> > Guess which device driver feels a bit chatty?
> >
> > PASS: mount no proc [GNUFAIL]
> > PASS: mount /proc
> > PASS: mount list1
> > VFS: Can't find ext3 filesystem on dev loop0.
> > PASS: mount vfat image (autodetect type)
> > ext3: No journal on filesystem on loop1
> > PASS: mount ext2 image (autodetect type)
> > PASS: mount remount ext2 image noatime
> > PASS: mount remount ext2 image ro remembers noatime
> > ext3: No journal on filesystem on loop0
> > PASS: umount freed loop device
> > PASS: mount remount nonexistent directory
> > PASS: mount -a no fstab
>
> Hrm, yes, 2 of those lines do come from ext3.
> Where do the rest of them come from?
>
>
> ---
> ~Randy
> You can't do anything without having to do something else first.
> -- Belefant's Law
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
