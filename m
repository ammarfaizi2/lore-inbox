Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSHLP14>; Mon, 12 Aug 2002 11:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSHLP14>; Mon, 12 Aug 2002 11:27:56 -0400
Received: from phxby.engr.usu.edu ([129.123.21.101]:43704 "EHLO
	phxby.engr.usu.edu") by vger.kernel.org with ESMTP
	id <S318139AbSHLP1z>; Mon, 12 Aug 2002 11:27:55 -0400
Date: Mon, 12 Aug 2002 09:31:25 -0600
From: Irwan Hadi <irwanhadi@phxby.engr.usu.edu>
To: Kees Bakker <kees.bakker@altium.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 hda: lost interrupt
Message-ID: <20020812153125.GA29884@phxby.com>
References: <15703.24219.318219.380751@koli.tasking.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15703.24219.318219.380751@koli.tasking.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 09:07:07AM +0200, Kees Bakker wrote:

> With 2.5.31 I am getting
>  hda: lost interrupt
> 2.5.30 was booting OK (but had some other problems).
> 
> My machine has a MSI K7T266 Pro motherboard with Athlon 1.3GHz. It has a
> VIA chipset, 82C686b+VT8233. Harddisk: IBM Deskstar 60GXP, 40Gb.

Well on my machine, with Maxtor DiamondMax 40 and Asus A7A255 ->
AliMagic chipset, and with kernel 2.5.26 I was having the same problem
too.
It seems the problem might be because I was using ext3fs, which soon I
found out corrupt the filesystem because of this lost interrupt thing.
Or this problem might occur because my system is an AMD Athlon.

My solution was to move back to ext2fs and kernel 2.4.18, although for
this I needed to fsck the hard drive a couple times because of the
occured corruption to the filesystem.
