Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263100AbTCSSLB>; Wed, 19 Mar 2003 13:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263111AbTCSSLB>; Wed, 19 Mar 2003 13:11:01 -0500
Received: from ool-43524450.dyn.optonline.net ([67.82.68.80]:52230 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S263100AbTCSSLA>;
	Wed, 19 Mar 2003 13:11:00 -0500
Date: Wed, 19 Mar 2003 13:21:43 -0500
Message-Id: <200303191821.h2JILh1B012704@buggy.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: "Vladimir B. Savkin" <savkin@shade.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100+NAPI failure
In-Reply-To: <20030319134341.GA26128@tentacle.sectorb.msk.ru>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003 16:43:41 +0300, Vladimir B. Savkin <savkin@shade.msu.ru> wrote:

> It seems to work with this one:
> 
> 02:03.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev
> 02)
[...]
> Unfortunally, I could not get this NIC to work with oversized frames
> to implement 802.1q, both with eepro100 and e100 drivers :(

Indeed, the 82557 does not support frames larger than 1500 bytes -- and 
you'd need an extra 4 bytes for the vlan tag.

Only the 82558+ (PCI rev 4 or higher) supports huge frames.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
