Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265534AbRGCRXM>; Tue, 3 Jul 2001 13:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265478AbRGCRWw>; Tue, 3 Jul 2001 13:22:52 -0400
Received: from t2.redhat.com ([199.183.24.243]:46842 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265537AbRGCRWl>; Tue, 3 Jul 2001 13:22:41 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010703131031.A25977@thyrsus.com> 
In-Reply-To: <20010703131031.A25977@thyrsus.com>  <200107031642.f63GgEG25604@snark.thyrsus.com> <29475.994179630@redhat.com> 
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cross-reference analysis reveals problems in 2.4.6pre9 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jul 2001 18:22:19 +0100
Message-ID: <31556.994180939@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  I put the symbols we discussed previously on my ignore list.  What's
> your beef this time?

It looked like you were again reporting config symbols which the user can't
be asked about - because they're only there as dependencies or as ifdefs in
the code, rather than as selectable options.

Upon further investigation, it seems I was mistaken. I apologise for my tone.

In fact, it seems that a lot of MIPS code has been merged into -pre9, and 
those options _are_ now selectable, rather than just being there as 
dependencies for some of my code. 

CONFIG_MTD_OCELOT is mine and I thought I'd already submitted help text for
it - evidently I'd missed it but because its dependencies were unselectable
your scripts weren't noticing it:

Momenco Ocelot boot flash device
CONFIG_MTD_OCELOT
  This enables access routines for the boot flash device and for the 
  NVRAM on the Momenco Ocelot board. If you have one of these boards
  and would like access to either of these, say 'Y'.


--
dwmw2


