Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267194AbSLKPzA>; Wed, 11 Dec 2002 10:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267195AbSLKPy7>; Wed, 11 Dec 2002 10:54:59 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:53442
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267194AbSLKPy7>; Wed, 11 Dec 2002 10:54:59 -0500
Subject: Re: [2.4]ALi M5451 sound hangs on init; workaround
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fedor Karpelevitch <fedor@apache.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Vicente Aguilar <bisente@bisente.com>,
       alsa-devel@lists.sourceforge.net,
       Debian-Laptops <debian-laptop@lists.debian.org>
In-Reply-To: <200212110715.20617.fedor@apache.org>
References: <200212110715.20617.fedor@apache.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 16:35:50 +0000
Message-Id: <1039624550.18087.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 15:15, Fedor Karpelevitch wrote:
> (currently 2.4.20-ac1 + hirofumi patch). I traced it down to the line 
> where it hangs - that is drivers/sound/trident.c:3379 which says:
> pci_write_config_byte(pci_dev, 0xB8, ~temp);
> 
> removing this line fixes the problem for me.
> I am not sure what would be the proper fix

Thats a big clue. ATI haven't released docs for the Radeon IGP so
support is minimal and very much 'done the hard way'. I do have ALi docs
however which may help.

