Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265095AbUFAQSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265095AbUFAQSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbUFAQR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:17:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41180 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265095AbUFAQHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:07:44 -0400
Date: Tue, 1 Jun 2004 18:07:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: 2.6.7-rc2-mm1: e1000_ethtool.c compile error
Message-ID: <20040601160735.GE25681@fs.tum.de>
References: <20040601021539.413a7ad7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601021539.413a7ad7.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 02:15:39AM -0700, Andrew Morton wrote:
>...
> All 296 patches:
>...
> bk-netdev.patch
>...

This caused the following compile error:

<--  snip  -->

...
  CC      drivers/net/e1000/e1000_ethtool.o
drivers/net/e1000/e1000_ethtool.c:57: parse error before `static'
...
{standard input}: Assembler messages:
{standard input}:372: Error: symbol `e1000_get_rx_csum' is already defined
{standard input}:381: Error: symbol `e1000_set_rx_csum' is already defined
{standard input}:409: Error: symbol `e1000_get_tx_csum' is already defined
{standard input}:419: Error: symbol `e1000_set_tx_csum' is already defined
{standard input}:446: Error: symbol `e1000_set_tso' is already defined
{standard input}:2905: Error: symbol `e1000_diag_test' is already defined
make[3]: *** [drivers/net/e1000/e1000_ethtool.o] Error 1

<--  snip  -->

Looking at the diff, and the similar problems in 
drivers/scsi/sr_ioctl.c, it seems either BK produced complete bullshit
or someone has smoked some _real_ bad stuff...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

