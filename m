Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131082AbRBWDsf>; Thu, 22 Feb 2001 22:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131208AbRBWDsP>; Thu, 22 Feb 2001 22:48:15 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:60039 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S131082AbRBWDsM>;
	Thu, 22 Feb 2001 22:48:12 -0500
Message-ID: <3A95DD6B.58771190@mirai.cx>
Date: Thu, 22 Feb 2001 19:47:55 -0800
From: J Sloan <jjs@mirai.cx>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Murray <jjm@jjm.com>
CC: jeff@CYTE.COM, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 seems to break loopback and/or mount
In-Reply-To: <Pine.LNX.4.30.0102222215190.8939-100000@light.jjm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Red Hat 7.x running nicely on a number of machines
here w/ no problem, with all apologies to the Red Hat
bashers -

The real problem is loopback is broken, and the
fix still needs to be merged.

In the meantime, Jens Axboe's loop patches will
make it work -

ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.2-pre4/

jjs

 Murray wrote:

> On Thu, 22 Feb 2001 jeff@CYTE.COM wrote:
>
> Compiling with kgcc compiler from RedHat 7.0 breaks loopback in the
> way you describe on 2.4.2-prex kernels and I suspect also in the real 2.4.2.
>
> Jim
>
> > Please CC me on replies. I just joined the list and don't want
> > to miss any replies.
> >
> > I have been running 2.4.1-pre10 for quite some time with no
> > problems. I just upgraded to 2.4.2 and everything seem to work
> > fine until I did...  (as root or course)
> >
> > mount -t iso9660 -o loop,ro mycdimage.iso /mnt/cdrom
> >
> > at which point the mount process hung in an uninterruptable sleep.
> > after that I can no longer successfully issue any other mount
> > commands, including non-loopback mounts. I can mount/unmount
> > regular partitions before mounting anything via loopback.
> >
> > Any ideas as to what is wrong?
> > The only thing I can think of is that my modutils is v2.3.19
> > but I doubt that is doing it as the loop module and other modules
> > are loaded fine.
> >
> > If anybody has an idea as to what I broke please let me know.
> > I will upgrade modutils tomorrow and see if the problem goes
> > away while I wait for a possibly more accurate response.
> >
> > Thank you,
> >
> > Jeff Wiegley
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> --
> Jim Murray         jjm@jjm.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

