Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316163AbSFUBek>; Thu, 20 Jun 2002 21:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSFUBej>; Thu, 20 Jun 2002 21:34:39 -0400
Received: from holomorphy.com ([66.224.33.161]:27073 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316163AbSFUBej>;
	Thu, 20 Jun 2002 21:34:39 -0400
Date: Thu, 20 Jun 2002 18:34:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
Message-ID: <20020621013406.GA22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020620172059.GW22961@holomorphy.com> <Pine.LNX.4.44.0206201929310.9805-100000@e2> <20020620181729.GY22961@holomorphy.com> <20020620192633.GZ22961@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020620192633.GZ22961@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 12:26:33PM -0700, William Lee Irwin III wrote:
> The final piece, built on top of the previous two. Please comment and/or
> use your discretion. Although I test compiled and booted it on UP i386,
> this may not be the desired cleanup. The original purpose of this was to
> enforce the usage of Linux' standard list data type for the pidhash.

Okay, one more piece, thanks to Brad Heilbrun <bheilbrun@paypal.com>:


Cheers,
Bill



diff -urN linux-2.5.23-virgin/kernel/fork.c linux-2.5.23-wli/kernel/fork.c
--- linux-2.5.23-virgin/kernel/fork.c	Thu Jun 20 18:21:18 2002
+++ linux-2.5.23-wli/kernel/fork.c	Thu Jun 20 18:21:31 2002
@@ -61,7 +61,7 @@
 	} while (!pidhash && size >= sizeof(list_t));
 
 	if (!pidhash)
-		panic("Failed to allocated pid hash table!\n");
+		panic("Failed to allocate pid hash table!\n");
 
 	pidhash_size = size/sizeof(list_t);
 
