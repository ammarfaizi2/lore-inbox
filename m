Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267699AbTAMBHg>; Sun, 12 Jan 2003 20:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267701AbTAMBHf>; Sun, 12 Jan 2003 20:07:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:34488 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267699AbTAMBHd> convert rfc822-to-8bit;
	Sun, 12 Jan 2003 20:07:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: updated CDROMREADAUDIO DMA patch
Date: Sun, 12 Jan 2003 17:16:43 -0800
User-Agent: KMail/1.4.3
Cc: lkml <linux-kernel@vger.kernel.org>
References: <3E177058.FF41AA10@digeo.com> <20030112231606.GA1762@werewolf.able.es>
In-Reply-To: <20030112231606.GA1762@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301121716.44099.akpm@digeo.com>
X-OriginalArrivalTime: 13 Jan 2003 01:16:16.0359 (UTC) FILETIME=[5ED93770:01C2BAA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun January 12 2003 15:16, J.A. Magallon wrote:
>
> On 2003.01.05 Andrew Morton wrote:
> > A refresh and retest of this patch, against 2.4.21-pre2.  It would
> > be helpful if a few (or a lot of) people could test this, and report
> > on the result.   Otherwise it'll never get anywhere...
> > 
> > Reading audio from IDE CDROMs always uses PIO.  This patch teaches the kernel
> > to use DMA for the CDROMREADAUDIO ioctl.
> > 
> 
> cdparanoia oopses on top of latest -aa:
> 
> Checking /dev/cdrom for cdrom...
> Testing /dev/cdrom for cooked ioctl() interface
>     CDROM sensed: ATAPI compatible CREATIVE CD5230E
> Verifying drive can read CDDA...
> Unable to handle kernel NULL pointer dereference at virtual address 00000014

Yup, we seem to have a bit of a problem there.  It works fine on the five
machines which I tried it on.

Oh well, thanks for testing.  It's unlikely that I will do any further work
on this.


