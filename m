Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbRBHFEN>; Thu, 8 Feb 2001 00:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129294AbRBHFED>; Thu, 8 Feb 2001 00:04:03 -0500
Received: from viemta06.chello.at ([195.34.133.56]:50593 "EHLO
	viemta06.chello.at") by vger.kernel.org with ESMTP
	id <S129257AbRBHFDw>; Thu, 8 Feb 2001 00:03:52 -0500
Date: Thu, 8 Feb 2001 06:03:49 +0100
From: Dejan Muhamedagic <dejan@xsoft.at>
To: linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Re: 2.4.1-ac5 - The loopback hang saga continues (not me ?)
Message-ID: <20010208060349.D1416@smtp.chello.at>
Reply-To: Dejan Muhamedagic <dejan@xsoft.at>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
In-Reply-To: <Pine.LNX.4.21.0102071723090.7611-100000@winds.org> <14977.61456.680691.926157@rhino.thrillseeker.net> <14978.2306.408780.856419@pcg.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <14978.2306.408780.856419@pcg.localdomain>; from Pascal.Brisset@wanadoo.fr on Thu, Feb 08, 2001 at 03:48:34AM +0100
Organization: XSoft GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same here.  I have had no problems with either 2.4.0 or 2.4.1,
and I don't even have the Axboe's patch applied.  Which makes me
wonder where is the problem.

I am also using encryption (patch-int-2.4.0.3, idea cipher) and
util-linux-2.10o.  The container file is not as big, only 256MB
with 65MB of data, and the largest file is ~30MB.  I had to
convert from the blowfish and used dump|restore.  There were no
problems whatsoever.

Dejan

On Thu, Feb 08, 2001 at 03:48:34AM +0100, Pascal Brisset wrote:
> FYI following hints from the linux-crypto mailing-list archives, I am
> using the following configuration :
> 
> linux-2.4.0
> patch-int-2.4.0.3
> http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0/loop-1.gz
> http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0/loop-bdev-inc-1.gz
> util-linux-2.10o
> Documentation/crypto/util-linux-2.10o.patch
> 
> I setup an encrypted 2097152000 byte loopback partition and moved
> 800MB of data there, including a 90MB file.
> 
> My only problems are:
> - rc.d/init.d/S01reboot sometimes fails to unmount partitions with
>   loop files on them (this already happened with 2.2.17).
> - losetup after losetup -d sometimes fails.
> 
> -- Pascal
> 
> 
> Linux-crypto:  cryptography in and on the Linux system
> Archive:       http://mail.nl.linux.org/linux-crypto/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
