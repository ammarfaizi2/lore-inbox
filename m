Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284857AbRLMT3v>; Thu, 13 Dec 2001 14:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284917AbRLMT3m>; Thu, 13 Dec 2001 14:29:42 -0500
Received: from [208.46.240.239] ([208.46.240.239]:29626 "EHLO mail.empexis.com")
	by vger.kernel.org with ESMTP id <S284857AbRLMT3a>;
	Thu, 13 Dec 2001 14:29:30 -0500
Message-ID: <3C18F4F3.4EC54A19@empexis.com>
Date: Thu, 13 Dec 2001 13:35:31 -0500
From: Joy Almacen <joy@empexis.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: pivot_root and initrd kernel panic woes
In-Reply-To: <3C165586.457A26F0@empexis.com> <20011213190750.A4460@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

I have tried every imaginable root device out there but with no success.

Thank you though  for all  your emails.  I gave up on RH 7.1
and decided to install RH7.2.  SMP is now enabled only after
configuring the BIOS of Proliant 6000 to "Linux" as the
OS. Now it is working the way we expect it.     I still
have issues with my Fiber Channel but that's not critical at the moment.

There is definitely something screwy with the mkinitrd RPM that was
supplied by RedHat.

Good day,



"Stephen C. Tweedie" wrote:

> Hi,
>
> On Tue, Dec 11, 2001 at 01:50:46PM -0500, Joy Almacen wrote:
>
> > After which I added this line  my  /etc/lilo.conf file:
> >
> > image=/boot/vmlinuz-2.4.9-12smp
> >         label=2.4.9smp
> >         append="initrd=/boot/initrd-2.4.9-12smp.img root=/dev/ram0
> > init=/linuxrc rw"
>
> That's your problem.  You need to specify your real root device in the
> "root=" section; for example, mine looks like
>
> image=/boot/vmlinuz-2.4.9-13
>         label=linux
>         initrd=/boot/initrd-2.4.9-13.img
>         read-only
>         root=/dev/md1
>
> The initrd magic happens before the real root gets loaded: you don't
> need to point root to /dev/ram0 to get a ramdisk.
>
> Cheers,
>  Stephen

