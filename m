Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbRGODkY>; Sat, 14 Jul 2001 23:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265802AbRGODkN>; Sat, 14 Jul 2001 23:40:13 -0400
Received: from weta.f00f.org ([203.167.249.89]:40579 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S265786AbRGODkE>;
	Sat, 14 Jul 2001 23:40:04 -0400
Date: Sun, 15 Jul 2001 15:40:08 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@caldera.de>,
        Gunther Mayer <Gunther.Mayer@t-online.de>, paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
Message-ID: <20010715154008.B7624@weta.f00f.org>
In-Reply-To: <E15LTIY-0001Ul-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15LTIY-0001Ul-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 06:33:45PM +0100, Alan Cox wrote:

    That just generates work for the glibc folks when they are working
    off copies of kernel header snapshots as they need to

Can't we just do something like:


/* KERNEL_PRIVATE_BEGIN: blah */

struct internal organs(int foo, char *bar);

/* KERNEL_PRIVATE_END */

sort of thing? That way glibc people can use sed to eliminate bogons
and confilcts and they can also submit patches for areas of overlap
the kernel people miss --- without fear of breaking the kernel?

Seems win-win to me and stops glibc and kernel developers from having
to trip over people and will allow us to eliminate all the rediculous
numbers of __KERNEL__ checks.




  --cw
