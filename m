Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbRLWBgR>; Sat, 22 Dec 2001 20:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283048AbRLWBgG>; Sat, 22 Dec 2001 20:36:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19720 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283003AbRLWBf5>; Sat, 22 Dec 2001 20:35:57 -0500
Message-ID: <3C2534E6.3080806@zytor.com>
Date: Sat, 22 Dec 2001 17:35:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: dcinege@psychosis.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <Pine.GSO.4.21.0112180350550.6100-100000@weyl.math.psu.edu> <E16HwgA-0001uk-00@schizo.psychosis.com> <3C252861.3090600@zytor.com> <E16HxEq-00029F-00@schizo.psychosis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Cinege wrote:

> 
> I've patched GRUB to support loading the mutiple images. It would also
> be supported in syslinux, if you choose to implement it. Months
> ago when I asked you to implement it, you told me the idea was
> stupid.  : P   I will never let you forget this myopia. : >
> 


Holding a grudge, eh?  How very mature of you.

Seriously, I made it very clear at the time that I thought supporting 
*multiple ramdisks* were a stupid idea.  Perhaps you misunderstood, but 
I was talking about what some people had been requesting of loading a 
filesystem into /dev/ram0, another filesystem into /dev/ram1, etc., 
including waiting for a disk replacement in between.  Doing that in the 
bootloader is just idiotic, for the same reason all the crap in the 
current kernel is equally stupid (although forgivable for historical 
reasons.)

The reason to support uncompressed images -- as well as gaps between 
images -- is to let synthesis happen in the bootloader.  For example, 
some people have requested passing the PXE configuration packets to the 
kernel, which currently is all but impossible.  Presenting them as files 
in the initramfs is the natural way to do it.

Viros changes are drastic, no question about it, but dismissing them as 
"disaster" without further motivation is a bloody awfully arrogant.

	-hpa


