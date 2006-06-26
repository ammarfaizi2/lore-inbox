Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWFZPzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWFZPzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWFZPzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:55:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:1668 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750721AbWFZPzT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:55:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M6BS+hPwRm4dWNb7fHExRUljyriBBFZooh4nNI8KrhnaK6xFP7gkn/kPg5F+SMLPFU9MZYXxvpVnXnCxXw6nPdNRpho/FY3iq4U4amHpwAaqEkV2u4AOq7QRbzp4PjxZLgoD97N//fsvmSQ5vQsKwtU0IOnn2a8+vAdFiNrP2zA=
Message-ID: <9e4733910606260855kf2e57ado5c69d8295d1be5@mail.gmail.com>
Date: Mon, 26 Jun 2006 11:55:18 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Mauro Carvalho Chehab" <mchehab@infradead.org>
Subject: Re: [PATCH] Kconfig for radio cards to allow VIDEO_V4L1_COMPAT
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1151327213.3687.13.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <9e4733910606251040v62675399gdfe438aaac691a5a@mail.gmail.com>
	 <1151327213.3687.13.camel@praia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> Jon,
>
> Em Dom, 2006-06-25 às 13:40 -0400, Jon Smirl escreveu:
> > In Kconfig all of the radio cards depend on VIDEO_V4L1. But V4L1 has
> > been deprecated and replaced with V4L2. V4L2 offers a V4L1
> > compatibility layer. Should the Kconfig for these devices be changed
> > to depend on (VIDEO_V4L1. || VIDEO_V4L1_COMPAT)? I'm not the
> > maintainer for this but they seem to build ok.
> No, it isn't. V4L1_COMPAT gets a userspace request, using the obsoleted
> V4L1 API and converts into a V4L2 call to be handled by a V4L2 driver.
>
> All radio stuff at kernel are still using the old obsoleted V4L1 API,
> and requires some changes to be V4L2 compliant. The correct fix is to
> replace the old calls to V4L2 calls, and include videodev2.h header
> instead of videodev.h.

Is anyone who knows how V4L2 works going to port those drivers? I
would hate to see 20 device drivers lost because they weren't ported
and V4L1 gets removed.

> After those changes, we should move the dependencies to be VIDEO_V4L2,
> instead of VIDEO_V4L1.
>
> Cheers,
> Mauro.
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
