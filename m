Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292281AbSB0RBA>; Wed, 27 Feb 2002 12:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292810AbSB0RAn>; Wed, 27 Feb 2002 12:00:43 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:42156 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S292806AbSB0RAR>;
	Wed, 27 Feb 2002 12:00:17 -0500
Date: Wed, 27 Feb 2002 18:00:10 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Pau <linuxnow@wanadoo.es>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: how to migrate these drivers?
Message-ID: <20020227180010.A5325@fafner.intra.cogenit.fr>
In-Reply-To: <Pine.LNX.4.44.0202262352290.17648-100000@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0202262352290.17648-100000@pau.intranet.ct>; from linuxnow@wanadoo.es on Tue, Feb 26, 2002 at 11:54:55PM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pau <linuxnow@wanadoo.es> :
[...]
> I want to fix these drivers so that they compile in 2.5. Is anybody 
> working on it? Any rule of the thumb to do it?

Read Documentation/DMA-mapping.txt, especially "Types of DMA mappings", 
then figure how it's used in drivers/net/{3c59x,epic100,eepro100}.c for 
example. 
Side note: pci_{map/alloc}_xxx must be balanced to avoid leak -> a straight 
search/replace virt_to_xxx/pci_map won't necessarily be enough.

-- 
Ueimor
