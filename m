Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSG1IQY>; Sun, 28 Jul 2002 04:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSG1IQY>; Sun, 28 Jul 2002 04:16:24 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:53069 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S313060AbSG1IQX>; Sun, 28 Jul 2002 04:16:23 -0400
Date: Sun, 28 Jul 2002 11:19:33 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Buddy Lumpkin <b.lumpkin@attbi.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About the need of a swap area
Message-ID: <20020728081932.GV1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Buddy Lumpkin <b.lumpkin@attbi.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20020728065830.GT1465@niksula.cs.hut.fi> <FJEIKLCALBJLPMEOOMECIEADDAAA.b.lumpkin@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FJEIKLCALBJLPMEOOMECIEADDAAA.b.lumpkin@attbi.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 12:59:13AM -0700, you [Buddy Lumpkin] wrote:
> 
> In Solaris you don't even need to define a swap device at all.
> If your sure that you will never reach lotsfree (for that matter, nothing
> stops you from setting lotsfree, desfree and minfree to whatever value you
> want) Solaris will happily run without a swap device even defined.

You don't have to have swap device in linux either (afaik it has never been
mandatory). Linux will run without swap just like you would expect.

> Once you reach the lotsfree watermark it's a whole different story, then it
> makes perfect sense to queue up writes to the swap device and write
> them out to swap in a sensible way as you point out above, but when I made
> the comment above, I was referring to a system that is not low on memory.

Obviously, if you have heaps of free memory, linux will not usually touch
swap either. The exact point where swap starts to get used is of course a
matter of debate (and depends on vm implementation and tunables in linux).
But the point is: even if there is no immediate memory pressure, backing
pages to swap is no crime.


-- v --

v@iki.fi
