Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVCKXkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVCKXkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVCKXTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:19:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17413 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261839AbVCKW6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:58:33 -0500
Date: Fri, 11 Mar 2005 23:58:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <christoph@graphe.net>, linux-kernel@vger.kernel.org,
       mark@chelsio.com, netdev@oss.sgi.com, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: A new 10GB Ethernet Driver by Chelsio Communications
Message-ID: <20050311225831.GQ3723@stusta.de>
References: <Pine.LNX.4.58.0503110356340.14213@server.graphe.net> <20050311112132.6a3a3b49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311112132.6a3a3b49.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 11:21:32AM -0800, Andrew Morton wrote:
> Christoph Lameter <christoph@graphe.net> wrote:
> >
> > A Linux driver for the Chelsio 10Gb Ethernet Network Controller by
> >  Chelsio (http://www.chelsio.com). This driver supports the Chelsio N210
> >  NIC and is backward compatible with the Chelsio N110 model 10Gb NICs.
> 
> Thanks, Christoph.
> 
> The 400k patch was too large for the vger email server so I have uploaded it to
> 
>  http://www.zip.com.au/~akpm/linux/patches/stuff/a-new-10gb-ethernet-driver-by-chelsio-communications.patch
> 
> for reviewers.
>...

- my3126.c is unused (because t1_my3126_ops isn't used anywhere)
- what are the EXTRA_CFLAGS in drivers/net/chelsio/Makefile for?
- $(cxgb-y) in drivers/net/chelsio/Makefile seems to be unneeded
- completely unused global functions:
  - espi.c: t1_espi_get_intr_counts
  - sge.c: t1_sge_get_intr_counts
- the following functions can be made static:
  - sge.c: t1_espi_workaround
  - sge.c: t1_sge_tx
  - subr.c: __t1_tpi_read
  - subr.c: __t1_tpi_write
  - subr.c: t1_wait_op_done


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

