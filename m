Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289183AbSA1Jwb>; Mon, 28 Jan 2002 04:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289185AbSA1JwU>; Mon, 28 Jan 2002 04:52:20 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:13293 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S289183AbSA1JwG>; Mon, 28 Jan 2002 04:52:06 -0500
From: <benh@kernel.crashing.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>,
        Kristian <kristian.peters@korseby.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Date: Mon, 28 Jan 2002 10:51:36 +0100
Message-Id: <20020128095136.1298@mailhost.mipsys.com>
In-Reply-To: <3C550BD4.E9CBE6A@zip.com.au>
In-Reply-To: <3C550BD4.E9CBE6A@zip.com.au>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>At no stage does a packet-mode DMA error turn off drive-level
>DMA.  This is because some devices seem to perform ordinary
>ATA DMA OK, but screw up packet DMA.
>
>The kernel internally retries the requests when it performs fallback,
>so userspace shouldn't see any disruption as the kernel works
>out what to do.
>
>Once the drive has fallen back to single-frame (or PIO mode) for
>packet reads, the only way to get it back to a higher level is
>a reboot.

Doesn that mean that a bad media (typically a scratched CDROM) will
cause the drive to revert to PIO until next reboot ?

Ben.


