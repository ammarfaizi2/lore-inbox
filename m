Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316416AbSFEUmn>; Wed, 5 Jun 2002 16:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSFEUmm>; Wed, 5 Jun 2002 16:42:42 -0400
Received: from unet2-17.univie.ac.at ([131.130.232.17]:5504 "EHLO server.lan")
	by vger.kernel.org with ESMTP id <S316416AbSFEUmk>;
	Wed, 5 Jun 2002 16:42:40 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.19/20] KDE panel (kicker) not starting up
Date: Wed, 5 Jun 2002 22:41:12 +0200
User-Agent: KMail/1.4.5
In-Reply-To: <Pine.LNX.4.33.0206032033030.569-100000@devel.blackstar.nl>
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206052241.12604@pflug3.gphy.univie.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* bvermeul@devel.blackstar.nl -- Tuesday 04 June 2002 07:14:20:
> * On Mon, 3 Jun 2002, Adam Trilling wrote:
> > Make sure you have read and write perms on your home directory.  I had
> > that happen due to a misplaced chown -R once.
> > 
> > This is not a kernel question, however, and probably shouldn't be on this
> > list.
> 
> Everythink works using 2.5.17. So I think this *is* a kernel question.

I don't have the slightest doubt that it is a kernel bug: I observed the
same with the /dev/hdc device (the CDROM). Playing Audio-CD's doesn't work
since 2.5.19. It worked for years now with the same permissions, and giving
more liberal rights doesn't help either. It always returns with EACCES!

  open("/dev/cdrom", O_RDONLY|O_NONBLOCK) = 3
  ioctl(3, CDROMVOLREAD, 0xbffff1f8)      = -1 EACCES (Permission denied)
  ioctl(3, CDROMSUBCHNL, 0xbffff1fc)      = -1 EACCES (Permission denied)

It works, however, for root! Could this be some broken capability
settings? 

m.



PS: Sorry if this message creates a new thread. I'm not subscribed to
    the list and read it via usenet-mirror.





