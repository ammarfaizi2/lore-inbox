Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbRGPFf5>; Mon, 16 Jul 2001 01:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbRGPFfr>; Mon, 16 Jul 2001 01:35:47 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:27396 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S267199AbRGPFfd>; Mon, 16 Jul 2001 01:35:33 -0400
Date: Mon, 16 Jul 2001 06:32:47 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Adam <adam@eax.com>
cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate '..' in /lib 
In-Reply-To: <Pine.LNX.4.33.0107160009260.25850-100000@eax.student.umd.edu>
Message-ID: <Pine.LNX.4.33.0107160628430.3954-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001, Adam wrote:

> so use 'od' to see what the filename is composed of:
>
> 	eax /tmp % ls -la | grep "\.\." | od -a
> 	 .   .  sp  nl

Managed to get at the contents of the miscreant file:

[alex@tahallah]/lib > od ..*
od: ..: Is a directory
0000000 054501 033560 033122 021564 022552 067571 023157 005057
0000020 031501 075110 033157 045067 021561 005000
0000033

Looks like:

YA7p6R#t%joy&o
/3AzH6oJ7#q

Anyone recognize this?

Anyway I've nuked the file now and seems to be OK now. I think this
probably happened whilst I was installing when the power went out.

Thanks for all your help, and I'll force a fsck on reboot now.

-- 
Hey, they *are* out to get you, but it's nothing personal.

http://www.tahallah.demon.co.uk

