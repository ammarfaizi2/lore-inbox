Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131362AbRCWX55>; Fri, 23 Mar 2001 18:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131392AbRCWX5t>; Fri, 23 Mar 2001 18:57:49 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:54726 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131362AbRCWX5h>; Fri, 23 Mar 2001 18:57:37 -0500
Date: Sat, 24 Mar 2001 00:56:12 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings
Message-ID: <20010324005612.V11126@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010323011140.A1176@werewolf.able.es> <E14gFRT-0003f4-00@the-village.bc.nu> <20010323013800.A1918@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010323013800.A1918@werewolf.able.es>; from jamagallon@able.es on Fri, Mar 23, 2001 at 01:38:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 01:38:00AM +0100, J . A . Magallon wrote:
> Is there a non-written standard for coding that asm's ?
> For example:
> "      adcl 12(%1), %0\n"
> "1:    adcl 16(%1), %0\n"
> "      lea 4(%1), %1\n"
> 
> or
> 
> "adcl 12(%1), %0\n\t"
                     ^[1]
> "1:  adcl 16(%1), %0\n\t"
> "lea 4(%1), %1\n\t"

The first one is better readable and the latter one is more
portable (since the first may contain tabs in the string, instead
of spaces and no one sees this).

You'll see, what I mean with readable, if you omit the tab in [1].


Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
