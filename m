Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSG2IxN>; Mon, 29 Jul 2002 04:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSG2IxN>; Mon, 29 Jul 2002 04:53:13 -0400
Received: from ppp3290-cwdsl.fr.cw.net ([62.210.105.37]:25225 "EHLO
	bouton.inet6-interne.fr") by vger.kernel.org with ESMTP
	id <S313687AbSG2IxL>; Mon, 29 Jul 2002 04:53:11 -0400
Date: Mon, 29 Jul 2002 10:56:26 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Daniela Engert <dani@ngrt.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "L.C. Chang" <lcchang@sis.com.tw>
Subject: Re: SiS 5513 ATA133 support patch for 2.4.19-rc3-ac3
Message-ID: <20020729105626.A16395@bouton.inet6-interne.fr>
Mail-Followup-To: Daniela Engert <dani@ngrt.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"L.C. Chang" <lcchang@sis.com.tw>
References: <3D448052.4070805@inet6.fr> <20020729070252.9F16E1107A@mail.medav.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020729070252.9F16E1107A@mail.medav.de>; from dani@ngrt.de on lun, jui 29, 2002 at 09:11:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On lun, jui 29, 2002 at 09:11:34 +0200, Daniela Engert wrote:
> On Mon, 29 Jul 2002 01:37:54 +0200, Lionel Bouton wrote:
> 
> 
> Lionel,
> 
> as you already figured out, looking at the northbridge IDs is simply
> not sufficient to find out which capabilities and register layout the
> IDE controller in the southbridge (no matter if integrated or external)
> has.
> 
> Some comments:
> 
> 1) the 745 has an integrated southbridge and an ATA/100 capable IDE
> controller
> 

I believed so too, but Lei-Chun patch changed it to ATA133.
Lei-Chun, could you tell us what we can expect from 745 chips ?

> 2) the 646 (and most likely the 645 and others as well) may be paired
> with a 961 (ATA/100) or 961B (ATA133) MutIOL southbridge with different
> register programming values.
> 
> Thus simply ripping out some northbridge IDs wouldn't prevent
> corruption problems.
> 

I don't see why (unless you refer to the 962/963 problem I did mention).
If we remove the IDs, the chips will be detected as SiS5513 (ATA_16). If
I'm correct, in this mode (only allowing PIO modes and SW/MW DMA modes)
all chips are OK.
I didn't dig in all specs to check each config register change, but all I
saw was OK and I *never* received any data corruption report for a chip that
was configured as original SiS5513 (though I have many reports of bad
performance due to PIO modes being used in such cases).

LB.
