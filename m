Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSJRMEP>; Fri, 18 Oct 2002 08:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265004AbSJRMEP>; Fri, 18 Oct 2002 08:04:15 -0400
Received: from ns.suse.de ([213.95.15.193]:17682 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262876AbSJRMEO>;
	Fri, 18 Oct 2002 08:04:14 -0400
Date: Fri, 18 Oct 2002 14:10:10 +0200
From: Dave Jones <davej@suse.de>
To: Hiroshi Miura <miura@da-cha.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: NatSemi Geode improvement
Message-ID: <20021018141009.A26652@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Hiroshi Miura <miura@da-cha.org>, hpa@zytor.com,
	linux-kernel@vger.kernel.org, alan@redhat.com
References: <20021017171217.4749211782A@triton2> <20021017192041.B17285@suse.de> <20021018022901.CA2D811782A@triton2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021018022901.CA2D811782A@triton2>; from miura@da-cha.org on Fri, Oct 18, 2002 at 11:29:01AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 11:29:01AM +0900, Hiroshi Miura wrote:
 > I try now using set6x86 to set these registers, then can do most of these 
 > except for set_cx86_memwb().
 > 
 > To set the memory write-back, I need to set the CR0  which needs special previlleges.
 > set6x86 cannot set CR0.
 > 
 > the set_cx86_memwb() need to be done in the kernel
 > the others has no reason to do that.
 > it is ok?

It's all __init anyway, so it's ok I guess.
The added bloat for non-cyrix users is in the region of a few bytes...

My initial idea for this sort of thing was going to be to dump it
all in the early-userspace thing that Al Viro was hacking up.
Al, anything appearing in a last minute merge over the next
few days ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
