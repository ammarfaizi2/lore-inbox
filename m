Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316975AbSEWSRF>; Thu, 23 May 2002 14:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316978AbSEWSRE>; Thu, 23 May 2002 14:17:04 -0400
Received: from maile.telia.com ([194.22.190.16]:27116 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S316975AbSEWSRD>;
	Thu, 23 May 2002 14:17:03 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel?
In-Reply-To: <20020520223132.GC25541@kroah.com>
From: Peter Osterlund <petero2@telia.com>
Date: 23 May 2002 20:16:53 +0200
Message-ID: <m23cwiivai.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

>   Let me (and the linux-usb-devel list) know about any thoughts you have
>   pertaining to liking one of the drivers over the other one.  Speed
>   tests, size tests, code pretty tests, comment spelling tests,
>   documentation tests, you name it, I want to know about it.  If you
>   don't want your comments to be public, send them to me directly and I
>   will not let anyone else know what you said, but will use the info to
>   try to pick which one should stay.

I did a simple test reading a bunch of files from a Freecom CDRW
drive.

usb-uhci-hcd           17840   0 (unused)

        pengo:/cdrw$ time wc petero/mp3/madonna/*
        ...
         188462 1091976 50386286 total

        real    1m24.930s
        user    0m10.440s
        sys     0m1.360s

uhci-hcd               24608   0 (unused)

        pengo:/cdrw$ time wc petero/mp3/madonna/*
        ...
         188462 1091976 50386286 total

        real    1m33.095s
        user    0m12.670s
        sys     0m11.870s

So the usb-uhci-hcd driver is 27% smaller, gives a 10% higher transfer
rate and produces less system load during the data transfers. (About
70% idle time versus 50% idle time on my 233MHz MMX system.)

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
