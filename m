Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWIBToX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWIBToX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 15:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWIBToX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 15:44:23 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:27106 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751446AbWIBToM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 15:44:12 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dave Jones <davej@redhat.com>
Subject: Re: megaraid_sas suspend ok, resume oops
Date: Sat, 2 Sep 2006 21:47:05 +0200
User-Agent: KMail/1.9.3
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Jeff Chua <jeff.chua.linux@gmail.com>, Jens Axboe <axboe@kernel.dk>,
       Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com> <200608301054.56375.rjw@sisk.pl> <20060902133003.GB6108@redhat.com>
In-Reply-To: <20060902133003.GB6108@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609022147.05503.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 September 2006 15:30, Dave Jones wrote:
> On Wed, Aug 30, 2006 at 10:54:56AM +0200, Rafael J. Wysocki wrote:
> 
>  > > > But without 64 bit support, my notebook will suspend/resume many times
>  > > > without failing (with the 5 ahci patches from Pavel Machek)....
>  > > 
>  > > Neither swsusp (as far as I know) or suspend2 support CONFIG_HIGHMEM64G
>  > > at the moment, I'm afraid.
>  > > 
>  > > It's not impossible, we just haven't seen it as a priority worth putting
>  > > time into.
>  > 
>  > It looks like the Fedora default config has HIGHMEM64G set, so I'll be looking
>  > at it shortly.
> 
> There is no 'Fedora default config'. We ship a number of different kernels,
> some of which enable PAE, some disable it.
> 
> For FC5, the installer installs a PAE kernel if you have >4GB, or SMP.

Ah, that's why people get hit by it if they have less than 4GB. ;-)

> For FC6, it'll only install one if you have >4GB.
> (or possibly if you have an NX capable CPU, I forget if we enabled that
>  magick in the installer)
> 
> Precluding NX support + swsusp kinda sucks, but I guess it's a tiny subset of users.

Well, I think the majority of NX-capable CPUs are also x86_64, in which case
I'd recommend using a 64-bit kernel anyway.

Thanks for the clarification.

I was afraid the issue would be urgent, but it doesn't seem so now.  I'd like to
postpone fixing it until we can create suspend images larger that 350 meg on
i386 boxes with highmem (the patch is ready to go to -mm after 2.6.19-rc1 as
2.6.20 material).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-- 
VGER BF report: H 0.00668657
