Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317481AbSFHXyl>; Sat, 8 Jun 2002 19:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSFHXyk>; Sat, 8 Jun 2002 19:54:40 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:22516 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317481AbSFHXyj>; Sat, 8 Jun 2002 19:54:39 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Thunder from the hill <thunder@ngforever.de>,
        Michael De Nil <linux@aerythmic.be>
Subject: Re: /dev/input/mice problem with 2.4.19-pre9 & 10
Date: Sun, 9 Jun 2002 09:51:49 +1000
User-Agent: KMail/1.4.5
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206080522040.15675-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206090951.49761.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jun 2002 21:23, Thunder from the hill wrote:
> Hi,
>
> On Sat, 8 Jun 2002, Michael De Nil wrote:
> > When I move my mouse while catting /dev/input/mice, nothing appears ...
> >
> > Other USB-device work...
>
> Please try /dev/input/mouse0.
>
> [thunder@hawkeye.luckynet.adm /usr/src/thunder-2.5.20] (0) ls -l
> /dev/input/ total 0
> crw-r--r--    1 root     root      13,  63 Dec 31  1969 mice
> crw-r--r--    1 root     root      13,  32 Dec 31  1969 mouse0
That won't make any difference - it will say "no such device". 

Both devices are created by the same input subsystem mouse driver. That driver 
is loaded (because /dev/input/mice was able to be opened), but there is no 
underlying USB support for the input subsystem. Input subsystem support was 
made configurable in -pre9, and if you don't select that option, then the hid 
parser directs the output to /dev/usb/hiddevX.

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
