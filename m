Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265309AbSJRRtp>; Fri, 18 Oct 2002 13:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265223AbSJRRse>; Fri, 18 Oct 2002 13:48:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65294 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265336AbSJRR1K>; Fri, 18 Oct 2002 13:27:10 -0400
Message-ID: <3DB0459E.8070609@zytor.com>
Date: Fri, 18 Oct 2002 10:32:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Hiroshi Miura <miura@da-cha.org>, linux-kernel@vger.kernel.org,
       alan@redhat.com
Subject: Re: NatSemi Geode improvement
References: <20021017171217.4749211782A@triton2> <20021017192041.B17285@suse.de> <20021018022901.CA2D811782A@triton2> <20021018141009.A26652@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Oct 18, 2002 at 11:29:01AM +0900, Hiroshi Miura wrote:
>  > I try now using set6x86 to set these registers, then can do most of these 
>  > except for set_cx86_memwb().
>  > 
>  > To set the memory write-back, I need to set the CR0  which needs special previlleges.
>  > set6x86 cannot set CR0.
>  > 
>  > the set_cx86_memwb() need to be done in the kernel
>  > the others has no reason to do that.
>  > it is ok?
> 
> It's all __init anyway, so it's ok I guess.
> The added bloat for non-cyrix users is in the region of a few bytes...
> 
> My initial idea for this sort of thing was going to be to dump it
> all in the early-userspace thing that Al Viro was hacking up.
> Al, anything appearing in a last minute merge over the next
> few days ?
> 

Al has passed off the initramfs patch, and I will start integration of 
klibc into the kernel build tree next week.

(Quite a lot of work has been done on klibc in isolation; it just hasn't 
been part of the kernel build tree.  If that means it ends up being 
built separately it would be unfortunate but no disaster.)

	-hpa


