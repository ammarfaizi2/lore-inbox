Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUALCVV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 21:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUALCVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 21:21:20 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:60648 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266004AbUALCVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 21:21:19 -0500
Message-ID: <4002047C.5010808@cyberone.com.au>
Date: Mon, 12 Jan 2004 13:20:44 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Adrian Bunk <bunk@fs.tum.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny2
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au> <20040110004625.GB25089@fs.tum.de> <20040110221459.GN18208@waste.org>
In-Reply-To: <20040110221459.GN18208@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matt Mackall wrote:

>
>I like this stuff, but I think the first two bits are probably better
>done in mainline proper, perhaps Andrew will consider them now that
>2.6.0 is out. The -tiny approach is to make small tweaks on stuff
>without diverging far from the mainline infrastructure. I'm trying to
>keep most of the patches independent. I've basically already hacked my
>owned version of the third bit (cpu support code selection) in an
>earlier -tiny release, hadn't noticed the mtrr bits yet.
>

The problem is, you aren't supposed to remove *any* cpu support code
with the current scheme unless the kernel is definitely not supposed
to run on that cpu. So a selection of 386 means you have to keep everything.
This gets a bit hairy when you select eg. Pentium 4, and try to work
out whether K7 should be supported or not...

Which is where Adrian's scheme comes in. I guess there are still probably
a lot of other things with better complexity/size saving ratio though,
but I would also like to see it in 2.6.

