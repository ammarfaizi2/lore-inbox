Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbSKBUIf>; Sat, 2 Nov 2002 15:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSKBUIf>; Sat, 2 Nov 2002 15:08:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1032 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261372AbSKBUId>; Sat, 2 Nov 2002 15:08:33 -0500
Message-ID: <3DC3C1AA.7060602@zytor.com>
Date: Sat, 02 Nov 2002 04:14:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
CC: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
References: <3DC38939.90001@pobox.com> <20021102101239.A9442@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter wrote:
> On Sat, Nov 02, 2002 at 03:13:45AM -0500, Jeff Garzik wrote:
> 
>>#4 - move mounting root to userspace
>>
>>People probably breathed a sigh of relief at patch #3, they will heave a 
>>bigger sigh for this patch :)   This moves mounting of the root 
>>filesystem to early userspace, including getting rid of 
>>NFSroot/bootp/dhcp code in the kernel.
> 
> 
> For those of us who only develop on nfsroot-based systems, does this
> step include adding userspace network interface configuration and
> bootp/dhcp client functionality to kinit?  I want to assume that
> "getting rid of NFSroot/bootp/dhcp" means moving that particular
> functionality as part of this step.  Just wondering what the
> short-term impact will be on the poor embedded guys. :)
> 

Probably not to kinit, but to early userspace, yes.  There is no real 
reason to put everything into kinit, and a lot of these things we have 
already written up as part of the klibc bundle.

	-hpa



