Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129173AbRBLTto>; Mon, 12 Feb 2001 14:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129382AbRBLTte>; Mon, 12 Feb 2001 14:49:34 -0500
Received: from lairdtest1.internap.com ([206.253.215.67]:34313 "EHLO
	lairdtest1.internap.com") by vger.kernel.org with ESMTP
	id <S129173AbRBLTt2>; Mon, 12 Feb 2001 14:49:28 -0500
Date: Mon, 12 Feb 2001 11:49:26 -0800 (PST)
From: Scott Laird <laird@internap.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <969bc2$seh$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.31.0102121147390.25638-100000@lairdtest1.internap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 Feb 2001, H. Peter Anvin wrote:
>
> Just checked my own code, and SYSLINUX does indeed support 115200 (I
> changed this to be a 32-bit register ages ago, apparently.)  Still
> doesn't answer the question "why"... all I think you do is increase
> the risk for FIFO overrun and lost characters (flow control on a boot
> loader console is vestigial at the best.)

It's simple -- we want the kernel to have its serial console running at
115200, and we don't want to have to change speeds to talk to the
bootloader.  Some boot processes, particularaly fsck, can be *REALLY*
verbose on screwed up systems.  I've seen systems take hours to run fsck,
even on small filesystems, simply because they were blocking on a 9600 bps
console.


Scott

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
