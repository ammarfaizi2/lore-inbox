Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271928AbTGYGjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 02:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271929AbTGYGjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 02:39:41 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.27]:29517 "EHLO
	mwinf0404.wanadoo.fr") by vger.kernel.org with ESMTP
	id S271928AbTGYGjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 02:39:40 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: koraq@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [2.4.22-pre7] speedtouch.o unresolved symbols
Date: Fri, 25 Jul 2003 08:55:24 +0200
User-Agent: KMail/1.5.2
References: <20030724202048.GA16411@spearhead>
In-Reply-To: <20030724202048.GA16411@spearhead>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307250855.24218.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 July 2003 22:20, koraq@xs4all.nl wrote:
> After compiling kernel 2.4.22-pre7 the make modules_install failed with the
> following errors
>
> cd /lib/modules/2.4.22-pre7; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> pcmcia if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
> 2.4.22-pre7; fi depmod: *** Unresolved symbols in
> /lib/modules/2.4.22-pre7/kernel/drivers/usb/speedtch.o depmod:        
> shutdown_atm_dev_R0b9b1467
> depmod:         atm_charge_Rf874f17b
> depmod:         atm_dev_register_Rc23701a4
> make: *** [_modinst_post] Error 1

You need to enable ATM support (CONFIG_ATM).  To do this, you
need to enable support for experimental code (CONFIG_EXPERIMENTAL).

Duncan.
