Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTEGKEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTEGKEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:04:50 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:56740 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263055AbTEGKEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:04:48 -0400
Date: Wed, 7 May 2003 12:16:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix .altinstructions linking failures
Message-ID: <20030507101637.GB2389@wohnheim.fh-wedel.de>
References: <20030506063055.GA15424@averell> <20030507092329.GA2389@wohnheim.fh-wedel.de> <20030507094752.GA4050@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030507094752.GA4050@averell>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 11:47:52 +0200, Andi Kleen wrote:
> Seriously. To give some numbers. This is the maxi kernel (about 8MB .text,
> everything compiled in that compiles in 2.5.69) which is far too big to even 
> even boot.
> 
>  20 .exit.text    00005afa  c0ada3d0  c0ada3d0  009db3d0  2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
> 
> About 20k from 8MB
>
> On a realistic kernel that actually boots we are talking about 1-2KB,
> probably even less.

Sounds more like 1/2 maxi to me, but you are basically right. 2-3k on
one of my production embedded kernels. I can accept that, but it
doesn't really make me happy.

> If you really wanted to combat bloat there are a lot 
> other areas where you can avoid much more than 2KB with minimum effort.
> Just go through include/linux/* and move a few unnecessary inlines away, that
> will help much more. If you want to save real memory attack mem_map, like
> I proposed earlier.

Still on my list, but I didn't get to it yet.

> P.S.: In case someone is interested: The hall of shame for the 2.5.69 SMP
> maxi kernel (stuff that doesn't build) currently is:  Sound/Alsa (one driver 
> doesn't compile), USB (3 drivers don't compile), MTD (lots of stuff doesn't 
> compile).  Everything else is quite good.

Do you have a .config for that kernel. I tried to create a maximal one
for 2.5.69 as well, but the problems in the Subject: stopped me and ld
didn't give me enough clues, which drivers to remove.

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
