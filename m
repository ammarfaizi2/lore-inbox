Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315883AbSETLas>; Mon, 20 May 2002 07:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSETLar>; Mon, 20 May 2002 07:30:47 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:39133 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S315883AbSETLaq>;
	Mon, 20 May 2002 07:30:46 -0400
Date: Mon, 20 May 2002 14:30:42 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: OSS SB driver & ESS1688 & module reloading
Message-ID: <Pine.GSO.4.43.0205201423510.27490-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reporting it since I got the symptoms on two different systems
(Compaq laptop with SuSE 8.0 and Digital Celebris GL 5133 ST - both have
onboard ESS1688).

ESS1688 is on irq 5 and non-PNP. modprobe sb finds it by probing and
defaults to irq 7 (proably sensible default on some computers, I have
parport on irq 7). Fine, rmmod sb, modprobe sb irq=5. Works.

Now when I rmmod sb and try to re-insert it, things become strange.
sb module tells now that io, irq and dma parameters are all necessary.
It does work when I supply these parameters but why does it need them
the second time??? Looks like a bug.

Kernel is 2.4.19pre8 on Digital Celebris GL and SuSE 8.0 default 2.4
kernel on Compaq laptop (not here at the moment, can't check).

-- 
Meelis Roos (mroos@linux.ee)

