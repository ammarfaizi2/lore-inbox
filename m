Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUENRdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUENRdp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUENRdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:33:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58035 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261925AbUENRcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:32:16 -0400
Message-ID: <40A50292.3070601@pobox.com>
Date: Fri, 14 May 2004 13:32:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: netdev@oss.sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       Pete Popov <ppopov@mvista.com>
Subject: Re: [PATCH] remove comx drivers from tree
References: <20040507111725.GA11575@lst.de>
In-Reply-To: <20040507111725.GA11575@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> the drivers have been broken since pre-2.4.0, like referencing a symbol
> that was made procfs-internal in 2.3.x, haven't received maintainer
> updates for about the same period and MOD_{INC,DEC}_USE_COUNT usage that
> pretty much unfixable (inside warts of _horrible_ procfs abuse).
> 
> I'd say just kill them.

I have applied this to my netdev-2.6 tree, and so it should show up in 
-mm sometime.

  drivers/net/wan/Kconfig           |  113 -
  drivers/net/wan/Makefile          |    8
  drivers/net/wan/comx-hw-comx.c    | 1449 -------------------
  drivers/net/wan/comx-hw-locomx.c  |  495 ------
  drivers/net/wan/comx-hw-mixcom.c  |  959 ------------
  drivers/net/wan/comx-hw-munich.c  | 2853 
--------------------------------------
  drivers/net/wan/comx-proto-fr.c   | 1013 -------------
  drivers/net/wan/comx-proto-lapb.c |  550 -------
  drivers/net/wan/comx-proto-ppp.c  |  268 ---
  drivers/net/wan/comx.c            | 1127 ---------------
  drivers/net/wan/comx.h            |  231 ---
  drivers/net/wan/comxhw.h          |  112 -
  12 files changed, 9178 deletions(-)

Even though it is quite moldy, I want to give people some time to object 
before I remove it upstream.


BTW, I plan to remove rcpci driver at the suggestion of Pete Popov, as 
well.  It seems it's another "hasn't really worked since late 2.3.x 
days" driver, and nobody really has the hardware from this defunct 
company anymore, apparently.

	Jeff



