Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280671AbRKSTwS>; Mon, 19 Nov 2001 14:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280669AbRKSTwI>; Mon, 19 Nov 2001 14:52:08 -0500
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:30456 "EHLO
	gintaras.vetrunge.lt.eu.org") by vger.kernel.org with ESMTP
	id <S280663AbRKSTv7>; Mon, 19 Nov 2001 14:51:59 -0500
Date: Mon, 19 Nov 2001 21:51:12 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: DD-ing from device to device.
Message-ID: <20011119215112.B25118@gintaras>
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011119101340.I1308@lynx.no> <200111191728.SAA05962@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111191728.SAA05962@cave.bitwizard.nl>
User-Agent: Mutt/1.3.23i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 06:28:55PM +0100, Rogier Wolff wrote:
> Now, can someone tell me why "unlimited" is interpreted somehow as 2G
> or something thereabouts? :
> 
>  /home/wolff> limit
> cputime         unlimited
> filesize        unlimited

I seem to recall seeing something about this on lkml: the kernel
considers 0xffffffff to be unlimited internally, but the setrlimit
syscall converts user-supplied 0xffffffff into 0x7fffffff.

Here's the relevant thread:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0111.1/0086.html

Marius Gedminas
-- 
"If it ain't broke, don't fix it."
- Bert Lantz
