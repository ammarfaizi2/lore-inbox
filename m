Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292291AbSBYUqG>; Mon, 25 Feb 2002 15:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292290AbSBYUps>; Mon, 25 Feb 2002 15:45:48 -0500
Received: from 25-VALL-X12.libre.retevision.es ([62.83.208.153]:55568 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S291565AbSBYUp0>; Mon, 25 Feb 2002 15:45:26 -0500
Date: Mon, 25 Feb 2002 21:44:37 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HZ value used in kernel/acct.c
Message-ID: <20020225214437.C10218@ragnar-hojland.com>
In-Reply-To: <Pine.LNX.4.33.0202242217070.30805-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202242217070.30805-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Sun, Feb 24, 2002 at 10:35:33PM +0100
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 10:35:33PM +0100, Tim Schmielau wrote:
> What is the supposed unit of the ac_etime field of struct acct?
> The code in kernel/acct.c currently says
> 
>    ac.ac_etime = encode_comp_t(jiffies - current->start_time);
> 
> so it is given in multiples of HZ, which makes this value 
> platform-dependent (and subject of overflow after 48.5 days with HZ=1024). 
> In include/linux/acct.h however there is the definition
> 
>    #define AHZ             100
> 
> which somehow smells like the preferred time unit.
> Comments?

The acct.c implementation followed FreeBSD's which also expressed comp_t
in terms platform dependant 1/(A)HZ   You could check the "[Patch] fix
incorrect jiffies compares" thread for a fix on uptime and 64 bit jiffies
someone sent.. didn't pay attention in why it didn't get in, tho.

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."      [20 pend. Mar 10]
