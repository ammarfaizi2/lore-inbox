Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286583AbRLUVPS>; Fri, 21 Dec 2001 16:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286579AbRLUVPK>; Fri, 21 Dec 2001 16:15:10 -0500
Received: from mail50-s.fg.online.no ([148.122.161.50]:31916 "EHLO
	mail50.fg.online.no") by vger.kernel.org with ESMTP
	id <S286577AbRLUVO4>; Fri, 21 Dec 2001 16:14:56 -0500
Message-Id: <200112212114.WAA25384@mail50.fg.online.no>
Content-Type: text/plain; charset=US-ASCII
From: Svein Ove Aas <svein@crfh.dyndns.org>
Reply-To: svein.ove@aas.no
To: linux-kernel@vger.kernel.org
Subject: Re: sr: unaligned transfer
Date: Fri, 21 Dec 2001 22:14:46 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <m16HVwW-0005khC@gherkin.frus.com>
In-Reply-To: <m16HVwW-0005khC@gherkin.frus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21. December 2001 21:06, Bob_Tracy wrote:
> Jens Axboe wrote:
> > Please try and mount with -o loop instead.
>
> ???  Sorry if I'm being dense, but the file system is on a physical
> CD: it isn't an image file.  The mount command that has worked for me
> in the past is
>
> 	mount -t iso9660 /dev/sr1 /mnt -r
>
> The sr1 device isn't a typo: it's my cd writer.

I wouldn't presume to think I know the details here, but as far as I can tell 
the plain mount command treats it like a device, while using the loop device 
treats it like a file.

It should still be possible to read from the CD like normal, but any 
CD-specific fucntions will likely be disabled, although those are probably 
implemented as ioctls anyway.

So.. try it, and see what you get.
