Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVHaAbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVHaAbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 20:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVHaAbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 20:31:09 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:55824 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932296AbVHaAbJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 20:31:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AnlOhasRQtOJB5S/6P2hUkVWuOwAjPKWH8BC4sg9an/zsLjPQ8ubmqpD5EwDlmwFueKv4l0kylODY/m3voG4iCj8HTU9CFna+mnVc7w57526Ld3wjN/VFjvklEP7dNyfceR0AKnwhNgmok0xvWA2Or4KelLN/8snTanOYSBLh2s=
Message-ID: <58cb370e050830173044b86233@mail.gmail.com>
Date: Wed, 31 Aug 2005 02:30:55 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE HPA
Cc: Greg Felix <greg.felix@gmail.com>,
       Oliver Tennert <O.Tennert@science-computing.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1125421518.8276.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <58cb370e0508300916432fc003@mail.gmail.com>
	 <1125421518.8276.45.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-08-30 at 18:16 +0200, Bartlomiej Zolnierkiewicz wrote:
> > HPA shouldn't be disabled by default and new kernel parameter ("hdx=hpa")
> > should be added for disabling HPA (yep, people with buggy BIOS-es will
> > have to add this parameter to their kernel command line, sorry).
> 
> Thats large numbers of systems. Large numbers of disks as strapped for
> 32GB and other clipping arrangements. With a vendor hat on thats
> unworkable because
> 
> a) It will stop thousands of people installing their systems
> b) Many users will get horrible corruption when they update the kernel
> and their box explodes as the fs tries to write to areas of disk that
> have vanished mysteriously.
> 
> (and we know all about this because ancient kernels had options for
> doing this in the compile that burned people)
> 
> So its a very bad idea indeed. A boot option for not disabling the hpa
> is possibly sensible for a few users who want that, or simply getting
> them to fix their buggy user space app would be even simpler.

OK, boot option for disabling HPA for users that want it is a indeed most
sensible approach.

> The only way I can see to truely automate it for most cases would be to
> snoop the partition table if its MSDOS format and see if the table
> matches the HPA clipped disk or the non-HPA clipped disk. If it matches
> the HPA clipped disk then you know not to fiddle. Otherwise its either a
> new disk, clipped by the 32GB jumper, non-x86 disk etc in which case you
> might as well disable any HPA.
> 
> Alan
