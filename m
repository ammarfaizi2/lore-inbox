Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbTAQQfD>; Fri, 17 Jan 2003 11:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267571AbTAQQfD>; Fri, 17 Jan 2003 11:35:03 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:1816
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267550AbTAQQfC>; Fri, 17 Jan 2003 11:35:02 -0500
Date: Fri, 17 Jan 2003 11:44:34 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH][2.5] fix for_each_cpu compilation on UP 
In-Reply-To: <200301171503.h0HF3vr02010@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301171138510.24250-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, James Bottomley wrote:

> zwane@holomorphy.com said:
> > This adds a definition for for_each_cpu when !CONFIG_SMP
> > Please apply 
> 
> Could you elaborate on the purpose of this a bit?  for_each_cpu() is only used 
> by the voyager subarch on x86 to traverse sparse CPU bitmaps efficiently in 
> critical path code.  It has no other use in x86 SMP because all other 
> subarch's tend to compact the CPU bitmap much more.
> 
> If there are other uses for the construct, it should probably be put in bitops 
> and become for_each_bit(i, mask)

It's still useful in the general case for avoiding access of per cpu 
memory when a cpu is offline as well as avoiding triggering events on 
cpus which aren't online anymore. I'm going to hold back on this for a bit 
till i actually release the code which depends on this infrastructure.

	Zwane
-- 
function.linuxpower.ca

