Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277732AbRJRO7e>; Thu, 18 Oct 2001 10:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277733AbRJRO7Z>; Thu, 18 Oct 2001 10:59:25 -0400
Received: from adsl-216-102-163-254.dsl.snfc21.pacbell.net ([216.102.163.254]:25255
	"EHLO windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S277732AbRJRO7R>; Thu, 18 Oct 2001 10:59:17 -0400
Date: Thu, 18 Oct 2001 07:56:52 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Norbert Preining <preining@logic.at>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.12 cannot find root device on raid
In-Reply-To: <20011018150141.A17493@alpha.logic.tuwien.ac.at>
Message-ID: <Pine.LNX.4.33.0110180755090.5641-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Oct 2001, Norbert Preining wrote:

> Hi!
>
> I have the following problem:
>
> kernel 2.4.12, md and raid1 compiled into the kernel.
> /dev/hdb old linux installation
> /dev/md0 -> /dev/hde1,/dev/hdg1 new installation
>
> When I boot my old installation the md device is automatically configured
> by the kernel and I can mount it (reiserfs) without any problems.
>
> When I try to boot the new installation with the same kernel the md device
> is initialized, but the kernel cannot mount the root device. I get msgs
> about FAT problems and about mounting root as msdos.
>
> Here some config files:
> lilo.conf:
> image = /boot/lx-2.4.12
> 	root = /dev/hdb1
> 	label = old
> image = /boot/lx-2.4.12
> 	root = /dev/md0
> 	label = new
> 	optional

To use a md as root, you need to add a kernel command line:

md0=1,/dev/hde1,/dev/hdg1

Put that in the append= line of lilo.conf or type it at the lilo command
prompt.

See also Documentation/md.txt in the Linux source tree.

-jwb

