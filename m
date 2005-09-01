Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVIARZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVIARZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVIARZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:25:33 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:20920 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1030253AbVIARZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:25:32 -0400
Date: Thu, 1 Sep 2005 19:29:38 +0200
From: DervishD <lkml@dervishd.net>
To: Mark Lord <lkml@rtr.ca>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SOLVED] USB Storage speed regression since 2.6.12
Message-ID: <20050901172938.GA207@DervishD>
Mail-Followup-To: Mark Lord <lkml@rtr.ca>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050901113614.GA63@DervishD> <4316EAD1.70300@ens-lyon.org> <20050901162353.GA67@DervishD> <43172CD4.3010308@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43172CD4.3010308@rtr.ca>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Mark :)

 * Mark Lord <lkml@rtr.ca> dixit:
> >the new implementation seems to rewrite the fat on every single
> >write (that's the reason of the slowdown, probably), and since I'm
> >not sure about the quality of the flash memory present in the
> >device, it is very probable that it would wear the first sectors
> >:( So I have to mount it 'async' under 2.6.13; I didn't have to do
> >that on older
> Nearly all flashcard devices (CompactFlash, SD, MMC, ..)
> have built-in wear-leveling in the on-card controller logic.

    I know, but this device is a very cheap MP3 player, and I'm
afraid that the builtin flash memory is not good enough to have
leveling circuitry... Just in case, using async is good.

    Thanks for the advice :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
