Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313325AbSC2BJm>; Thu, 28 Mar 2002 20:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313328AbSC2BJc>; Thu, 28 Mar 2002 20:09:32 -0500
Received: from 12-252-146-102.client.attbi.com ([12.252.146.102]:46346 "EHLO
	archimedes") by vger.kernel.org with ESMTP id <S313325AbSC2BJY>;
	Thu, 28 Mar 2002 20:09:24 -0500
Date: Thu, 28 Mar 2002 18:08:55 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.4.19-pre4-ac2 hang at boot with ALI15x3 chipset support
Message-ID: <20020329010855.GA871@opus>
Mail-Followup-To: James Mayer <james.mayer@acm.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <86387368@toto.iv> <m16qQix-0014LaC@malasada.lava.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Debian: Debian GNU/Linux http://www.debian.org/
From: James Mayer <james.mayer@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> James> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> James> hda: drive not ready for command
> 
> I ran into this as well under various kernels including 2.4.18.  Try
> adding:
>     append="idebus=50"
> 
> to the lilo stanza for your kernel.
> 
> It seems even after I amputated the offending "write" that causes the
> lockup, the bus speed was being set to 33MHz instead of 50Mhz.  The
> above solved the problem for me.

This worked for me as well -- interesting.

> For anyone else trying to configure the pcg-c1mrx or pcg-c1mv, I'm
> updating linux configuration document as I work through the
> setup of the various devices:
>     http://hale.org/~bhoward/issue_7/pcg-c1mrx.html

Good information there.  Oddly enough, I don't need to specify the
pci=conf2, though.

Thanks to everyone for the speedy assistance!
 - James
