Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130871AbQLILOb>; Sat, 9 Dec 2000 06:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131117AbQLILOV>; Sat, 9 Dec 2000 06:14:21 -0500
Received: from [213.8.184.80] ([213.8.184.80]:33548 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S130871AbQLILOO>;
	Sat, 9 Dec 2000 06:14:14 -0500
Date: Sat, 9 Dec 2000 12:12:31 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Matan Ziv-Av <matan@svgalib.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Big IDE HD unclipping and IBM drive
In-Reply-To: <Pine.LNX.4.21_heb2.09.0012082319530.962-100000@matan.home>
Message-ID: <Pine.LNX.4.21.0012091207500.2517-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Matan Ziv-Av wrote:

> Hi,
> 
> I have an IBM drive, DTLA-307075 (75GB), and a bios that hangs with
> large disks. I use a jumper to clip it to 32GB size, so the bios can
> boot into linux. The problem is that WIN_READ_NATIVE_MAX returns 32GB,
> and not the true size, and even trying to set the correct size with
> WIN_SET_MAX fails. Is there a way to use this combination (Bios, HD,
> Linux)?

I had the exact same problem. Jumper-clipping doesn't work, so the 
solution to this problem is applying the IDE patch to the kernel 
(www.linux-ide.org), and then use IBM's Disk Manager utilities to 
software-clip the drive (don't set the jumper).

Software-clipping does exactly the same as hardware clipping, except that
a jumper isn't involved, and the drive can be clipped back to full 
capacity. Each drive has a flash memory is once you do it you don't have
to do it again.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
