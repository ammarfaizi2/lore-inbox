Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267786AbUIOXmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267786AbUIOXmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIOXdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:33:43 -0400
Received: from pD9E7547E.dip0.t-ipconnect.de ([217.231.84.126]:1667 "EHLO
	achilles.nass-vogt.home") by vger.kernel.org with ESMTP
	id S267770AbUIOXcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:32:36 -0400
From: Hans-Frieder Vogt <hfvogt@arcor.de>
Reply-To: hfvogt@arcor.de
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Date: Thu, 16 Sep 2004 01:32:34 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
References: <200409130035.50823.hfvogt@arcor.de> <200409160040.03532.hfvogt@arcor.de> <20040915230936.GA24467@electric-eye.fr.zoreil.com>
In-Reply-To: <20040915230936.GA24467@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409160132.34160.hfvogt@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. September 2004 01:09 schrieb Francois Romieu:
> Hans-Frieder Vogt <hfvogt@arcor.de> :
> [...]
> [...]
>
> > Of course x86-64 has the address-space that enables >4GB RAM, and x86-64
> > always supports DAC (as stated in include/asm-x86_64/pci.h), but I have
> > currently only 1GB RAM, so, strictly speaking, DAC is not really
> > necessary.
>
> Worse than that: r8169 in 2.6.9-rc[1/2] does not advertise its ability to
> DMA to high memory.
>
> > Strange enough, the latest Realtek driver 2.2 does not even support DAC
> > (only the lower 32 bit of the DMA-Addresses are written to the
> > registers). Could it be that the Realtek driver does not support DAC for
> > a good reason?
> >
> > Anyway, I will continue searching for the problem...
>
> Can you simply try the attached patch with the network cable unplugged ?
>
> It will not fix your issue but if the result & 0x08 != 0, you can probably
> stop your testing for now as it will mean "known issue".
>
> --
> Ueimor

r8169: eth0: Config2 = 0x10

... does not seem to be the already known issue? Anyhow, if you have more 
ideas, I will be happy to test them :-)

Hans-Frieder

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt (at) arcor (dot) de
