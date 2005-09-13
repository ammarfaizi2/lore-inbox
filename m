Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVIMTdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVIMTdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbVIMTdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:33:20 -0400
Received: from pc1058.sks3.muni.cz ([147.251.210.58]:43142 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S932411AbVIMTdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:33:19 -0400
Date: Tue, 13 Sep 2005 21:34:02 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops 2.6.13-git6
Message-ID: <20050913193402.GI2383@mail.muni.cz>
References: <20050912102011.GA2379@mail.muni.cz> <1126530670.30449.64.camel@localhost.localdomain> <20050912180038.GE2382@mail.muni.cz> <1126562475.30449.94.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1126562475.30449.94.camel@localhost.localdomain>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 11:01:15PM +0100, Alan Cox wrote:
> In a tiny subset of cases and for PIO modes only for devices that match
> IDE generic PIO interfaces, providing the interface is not boot
> detected, you don't remove it when in use and the moon is in the right
> phase.

I'm not sure, if I understand correctly. However, I meant, in the case of hdd as
/dev/hda and cdrom as /dev/hdc, it works:
/usr/bin/hotswap --ide-controller 1 -n probe-ide
/usr/bin/hotswap --ide-controller 1 -n unregister-ide
remove cdrom here

after pluging cdrom back:
/usr/bin/hotswap --ide-controller 1 -n probe-ide
/usr/bin/hotswap --ide-controller 1 -n rescan-ide

I think, DMA cannot be turned on if cdrom was not plugged in at boot time for
some reason.

But things above do not work if hdd is /dev/hda and cdrom is /dev/hdb, i.e. on
the same channel.

Again, is it an IDE conception bug?

-- 
Luká¹ Hejtmánek
