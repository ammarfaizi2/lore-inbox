Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318342AbSIBRdU>; Mon, 2 Sep 2002 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318344AbSIBRdU>; Mon, 2 Sep 2002 13:33:20 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:30657 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S318342AbSIBRdT>;
	Mon, 2 Sep 2002 13:33:19 -0400
Date: Mon, 2 Sep 2002 19:37:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.33: modular ide breaks lilo ...
Message-ID: <20020902173748.GA9328@win.tue.nl>
References: <20020902162707.GA22182@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020902162707.GA22182@bytesex.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 06:27:07PM +0200, Gerd Knorr wrote:

> I've tried building the ide driver modular and insmod it using an
> initrd.  The kernel boots just fine, but lilo complains:
> 
> bogomips root ~# lilo
> Device 0x0300: Invalid partition table, 2nd entry
>   3D address:     1/0/262 (264096)
>   Linear address: 1/10/4175 (4209030)

What LILO version?
For many versions it will suffice to give LILO the linear or lba32 option.

> I've also noticed that the fdisk output looks different depending on
> modular vs. static ide, I suspect this is related.  With a modular IDE
> driver it looks like this:
> 
> bogomips root ~# fdisk -l /dev/hda
> 
> Disk /dev/hda: 16 heads, 63 sectors, 79780 cylinders
> Units = cylinders of 1008 * 512 bytes
> 
> With ide built-in statically fdisk prints this:
> 
> bogomips root ~# fdisk -l
> 
> Disk /dev/hda: 255 heads, 63 sectors, 5005 cylinders
> Units = cylinders of 16065 * 512 bytes

What fdisk version? Make sure you have a recent one.
Clearly, the rest of the fdisk output is a consequence of the different
geometries. The kernel boot messages will probably tell what happened.
I must still read this part of the kernel source again to see what the
current status is.

Andries

