Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319115AbSIJNcf>; Tue, 10 Sep 2002 09:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319118AbSIJNcf>; Tue, 10 Sep 2002 09:32:35 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:4861 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319115AbSIJNcf>; Tue, 10 Sep 2002 09:32:35 -0400
Subject: Re: [PATCH] 2.4.20-pre5-ac4: Add support for ALi 5451 gameport
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>
In-Reply-To: <20020910073838.A6113@ucw.cz>
References: <Pine.LNX.4.44.0209100118170.1462-100000@neptune.sol.net> 
	<20020910073838.A6113@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 14:40:12 +0100
Message-Id: <1031665212.31787.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 06:38, Vojtech Pavlik wrote:
> Very nice. I think this is for Alan. For normal 2.4, as you said,
> the pcigame.c code isn't much useful, because doesn't cooperate well
> with the trident.c code. For 2.5, pcigame code is embedded into
> trident.c to make things simpler.

I fixed that in 2.4 by making pcigame look for devices if the sound card
isnt compiled in for them, otherwise provide pcigame_attach and
pcigame_release functions that drivers can use to attach pci mmio
joystick interfaces to their hardware. Works very nicely and saves
embedded one completely in the other.

Alan

