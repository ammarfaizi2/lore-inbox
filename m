Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264300AbRF1Ukq>; Thu, 28 Jun 2001 16:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264280AbRF1Uk0>; Thu, 28 Jun 2001 16:40:26 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30099 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264260AbRF1UkP>;
	Thu, 28 Jun 2001 16:40:15 -0400
Message-ID: <3B3B9653.A8331780@mandrakesoft.com>
Date: Thu, 28 Jun 2001 16:40:51 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: ankry@green.mif.pg.gda.pl, elenstev@mesatop.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.6-pre6 fix drivers/net/Config.in error
In-Reply-To: <6121.993725018@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Thu, 28 Jun 2001 10:45:55 +0200 (MET DST),
> Andrzej Krzysztofowicz <ankry@pg.gda.pl> wrote:
> >Keith Owens wrote:
> >> Index: 6-pre6.1/drivers/net/Config.in
> >> -   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
> >> +   if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_PCI" = "y" ]; then
> 
> >CONFIG_EISA check in this condition is redundant.
> 
> True, but the line is a cut and paste from higher up in
> drivers/net/Config.in.  Even though it is redundant, it is consistent
> with the rest of the file.

It is not redundant because in theory CONFIG_EISA could exist without
CONFIG_ISA.

> drivers/net/Config.in needs a major cleanup, lots of the if statements
> can go and be replaced by dep_xxx statements, CONFIG_ETHERTAP is marked
> obsolete but is tested against experimental, CONFIG_ZNET is marked
> experimental but is tested against obsolete, etc.

Why not send me an incremental patch for these cleanups, on top of the
cleanup patch that (I hope!) Andrzej will send, in respond to me last
reply.

2.4 will be around for quite a while, and Config.in cleanups should
continue to go in.  Sure work should be directed towards 2.5..... but if
somebody sends me a 2.4 patch for drivers/net/Config.in cleanup, I sure
as hell will apply it.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
