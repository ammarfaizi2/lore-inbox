Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131150AbRAKKeY>; Thu, 11 Jan 2001 05:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131202AbRAKKeG>; Thu, 11 Jan 2001 05:34:06 -0500
Received: from Cantor.suse.de ([194.112.123.193]:40196 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131088AbRAKKeA>;
	Thu, 11 Jan 2001 05:34:00 -0500
Date: Thu, 11 Jan 2001 11:33:53 +0100
From: Andi Kleen <ak@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010111113353.B20569@gruyere.muc.suse.de>
In-Reply-To: <20010111005924.L29093@athlon.random> <200101110734.f0B7Y1x01512@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101110734.f0B7Y1x01512@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Jan 11, 2001 at 07:34:01AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 07:34:01AM +0000, Russell King wrote:
> 1. Yucky code in the NFS layers to copy a nfs_fh from userspace to kernel
>    space, translating it into something sane.
> 2. Yucky code in the NFS layers to manually handle the nfs_fh to knfs_fh
>    translation.
> 3. Accept the breakage of a *brand new* API in 2.2.18 and suffer zero
>    yucky code.

The change is rather useless anyways, because even in NFSv3 file handles
cannot be >64bytes. Would even fit in a char, doesn't need a short nor an
int. 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
