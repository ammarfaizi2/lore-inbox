Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281322AbRLGOEs>; Fri, 7 Dec 2001 09:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281483AbRLGOEg>; Fri, 7 Dec 2001 09:04:36 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:50693 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S281322AbRLGOED>; Fri, 7 Dec 2001 09:04:03 -0500
Date: Fri, 7 Dec 2001 17:03:41 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA on AXP & barriers
Message-ID: <20011207170341.A9959@jurassic.park.msu.ru>
In-Reply-To: <20011206061315.J13427@garloff.etpnet.phys.tue.nl> <20011206125935.A3930@jurassic.park.msu.ru> <20011207132505.B4229@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207132505.B4229@garloff.etpnet.phys.tue.nl>; from garloff@suse.de on Fri, Dec 07, 2001 at 01:25:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 01:25:05PM +0100, Kurt Garloff wrote:
> So I  wonder where the bug actually is. Somewhere in hardware; but I wonder
> whether the CMD646 or the 2117x (PYXIS/CIA) is to blame. The QLogicISP seems
> to happily do BM-DMA, so I'd point to the CMD646.

Hmm, it seems to be a pyxis bug; the hardware workaround exists, but
I guess that it might be not implemented properly on early miatas.
This also explains why I don't have that problem on lx164 and sx164.
>From pyxis manual:
"A.1 Read Page Problem
 PCI DMA reads that attempt to cross 8K page boundaries cause data corruption
 problems. A fix has been implemented with an Altera 7032 and two Pericom
 PI5C3400 bus switches and a diode."

> OTOH, the QLogic sits on
> the 2nd PCI bus (32bit), which could make a difference as well.

Certainly - the 2nd bus is behind PCI-PCI bridge.

Ivan.
