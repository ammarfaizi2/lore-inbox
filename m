Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSHOTEg>; Thu, 15 Aug 2002 15:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSHOTEf>; Thu, 15 Aug 2002 15:04:35 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:5130 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S317331AbSHOTEf>; Thu, 15 Aug 2002 15:04:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: henrique <henrique@cyclades.com>
Reply-To: henrique@cyclades.com
Organization: Cyclades Corporation
Subject: Problem with random.c and PPC
Date: Thu, 15 Aug 2002 16:10:02 +0000
User-Agent: KMail/1.4.1
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208151610.02252.henrique@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas !!!

You've got the point. My system is diskless, keyboardless and mouseless
therefore I will never get randomness without the patch you talked about.

BTW, does anyone know where I can found the patch to get randomness from the 
network cards interrupt ?

regards
Henrique

On Thursday 15 August 2002 06:25 pm, Andreas Dilger wrote:
> On Aug 15, 2002  15:14 +0000, henrique wrote:
> > Hello !!!
> >
> > I am trying to use a program (ipsec newhostkey) that uses the random
> > device provided by the linux-kernel. In a x86 machine the program works
> > fine but when I tried to run the program in a PPC machine it doesn't
> > work.
> >
> > Looking carefully I have discovered that the problem is in the driver
> > random.c. When the program tries to read any amount of data it locks and
> > never returns. It happens because the variable
> > "random_state->entropy_count" is always zero, that is, any random number
> > is generated at all !!!??.
> >
> > Does anyone know anything about this problem ? Any sort of help is very
> > welcomed.
>
> Maybe the PPC keyboard/mouse drivers do not add randomness?  You should
> also get randomness from disk I/O.  If your PPC system is diskless,
> mouseless, and keyboardless, there is also a patch for 2.4 which allows
> you to get randomness from network card interrupts, which is good enough
> for all but the most incredibly paranoid people.
>
> Cheers, Andreas

--

-------------------------------------------------------

-- 
---
Henrique Gobbi
Software Engineer
+55 11 50333339
Cyclades Corporation - The Leader in Linux Connectivity
