Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbTBCNqj>; Mon, 3 Feb 2003 08:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbTBCNqi>; Mon, 3 Feb 2003 08:46:38 -0500
Received: from gate.perex.cz ([194.212.165.105]:12560 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S266320AbTBCNqh>;
	Mon, 3 Feb 2003 08:46:37 -0500
Date: Mon, 3 Feb 2003 14:55:37 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "greg@kroah.com" <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PnP model
In-Reply-To: <20030202203641.GA22089@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0302031437310.1116-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I think that we need to discuss deeply the right PnP model. The 
actual changes proposed by Adam are going to be more and more complex 
without allowing the user interactions inside the "auto" steps. The 
auto-configuration might be good and bad as we all know, but having an 
method to skip it is necessary.

	I strongly vote to follow the same behaviour as PCI code does:
It means call the activation / enabling / setting functions from the 
probe() callbacks. Only the driver knows what's the best. Including 
the manual assignment of resources.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

