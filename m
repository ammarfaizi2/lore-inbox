Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289901AbSBSUgz>; Tue, 19 Feb 2002 15:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289877AbSBSUfV>; Tue, 19 Feb 2002 15:35:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16003 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289820AbSBSUeG>; Tue, 19 Feb 2002 15:34:06 -0500
Date: Tue, 19 Feb 2002 15:34:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ENOTTY from ext3 code?
In-Reply-To: <20020219190932.GA274@elf.ucw.cz>
Message-ID: <Pine.LNX.3.95.1020219153119.30420A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> ext3/ioctl.c:
> 
> ...
> 	return -ENOTTY;
> 
> Does it really make sense to return "not a typewriter" from ext3
> ioctl?

But yes! The de-facto return code for a file-system ioctl() that
is undefined, i.e., wrong parameter, is ENOTTY. This is because
it really means "Not a terminal". Terminals have the most ioctls.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

