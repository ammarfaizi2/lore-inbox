Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284285AbSABVSO>; Wed, 2 Jan 2002 16:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbSABVSG>; Wed, 2 Jan 2002 16:18:06 -0500
Received: from svr3.applink.net ([206.50.88.3]:48391 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S284314AbSABVRy>;
	Wed, 2 Jan 2002 16:17:54 -0500
Message-Id: <200201022117.g02LHbSr022224@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Keith Owens <kaos@ocs.com.au>, timothy.covell@ashavan.org
Subject: Re: system.map
Date: Wed, 2 Jan 2002 15:13:55 -0600
X-Mailer: KMail [version 1.3.2]
Cc: adrian kok <adriankok2000@yahoo.com.hk>, linux-kernel@vger.kernel.org
In-Reply-To: <9391.1010004875@ocs3.intra.ocs.com.au>
In-Reply-To: <9391.1010004875@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 14:54, Keith Owens wrote:
> On Wed, 2 Jan 2002 13:26:29 -0600,
>
> Timothy Covell <timothy.covell@ashavan.org> wrote:
> >	Of course, you can copy over the new System.map
> >file to /boot,  but their is no (easy) way of having more than
> >one active version via "lilo" or "grub".   And that could be
> >considered a deficiency of the Linux OS.
>
> Current versions of ps look for System.map in
>
>       $PS_SYSTEM_MAP
>       /boot/System.map-`uname -r`
>       /boot/System.map
>       /lib/modules/`uname -r`/System.map
>       /usr/src/linux/System.map
>       /System.map
>
> Copy System.map to /lib/modules/`uname -r`/System.map after make
> modules_install, remove any old map files from /boot and / and you
> don't need any symlink or bootloader tricks.

I saw that in the man page for "ps".  I think that your idea makes sense.

However, I'm concerned about searching in "/usr/src/linux" for it.
Linus has taken great pains to point out that we shouldn't be building
our kernels in /usr/src/linux, it would seem that this is reenforcing a
mistake.


>
> The 2.5 kernel build asks if you want to install System.map and
> .config.  If you say yes then the default location for these files in
> 2.5 is /lib/modules/`uname -r`/{System.map,.config}.


I knew that I was trying to download the 2.5.x series for a good reason. ;-)
My bandwidth hasn't let me get one full download yet, but I've got
all the 2.4.x patches that I could need.

-- 
timothy.covell@ashavan.org.
