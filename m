Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271331AbTHHHOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 03:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271337AbTHHHOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 03:14:14 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:24541 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S271331AbTHHHOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 03:14:02 -0400
Date: Fri, 8 Aug 2003 09:13:50 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre10-ac1 -- lots of unresolved symbols
Message-ID: <20030808071350.GJ7094@louise.pinerecords.com>
References: <20030807133053.GA18191@pwr.wroc.pl> <20030807140232.GC7094@louise.pinerecords.com> <20030807194953.GA15747@pwr.wroc.pl> <20030808065827.GA14918@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030808065827.GA14918@pwr.wroc.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [pawel.dziekonski@pwr.wroc.pl]
> 
> Hi again,
> 
> now i have just used defconfig after mrproper and this:
> 
> cd /lib/modules/2.4.22-pre10-ac1; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map
> 2.4.22-pre10-ac1; fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.22-pre10-ac1/kernel/drivers/n
> et/dummy.o
> depmod:         register_netdev_Rsmp_f8a1d0ee
> depmod:         __kfree_skb_Rsmp_f5f3cd6e
> depmod:         kfree_Rsmp_037a0cba
> depmod:         dev_alloc_name_Rsmp_44746846
> depmod:         kmalloc_Rsmp_93d4cfe6
> depmod:         ether_setup_Rsmp_d95733a5
> depmod:         unregister_netdev_Rsmp_b48d7ea9
> make: *** [_modinst_post] Bd 1
> 
> any idea? P

Can you retry w/ CONFIG_MODVERSIONS unset?
