Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUIPJDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUIPJDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUIPJDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:03:43 -0400
Received: from gate.in-addr.de ([212.8.193.158]:63704 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S267863AbUIPJDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:03:40 -0400
Date: Thu, 16 Sep 2004 11:03:28 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Netdev <netdev@oss.sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
Message-ID: <20040916090328.GO26852@marowsky-bree.de>
References: <4148991B.9050200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4148991B.9050200@pobox.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-09-15T15:33:47,
   Jeff Garzik <jgarzik@pobox.com> said:

> Then, your host system OS will communicate with the Linux kernel running 
> on the card across the PCI bus, using IP packets (64K fixed MTU).
> 
> This effectively:

Actually, given that there's almost no reason to offload TCP/IP
processing for speed (better spent the money on CPU / memory for the
main system), I like the idea of this for security: Off-load the packet
filtering to create an additional security barrier. (Different CPU
architecture and all that.)

(With two cards, one could even use the conntrack fail-over internally.
- A Linux-running NIC with builtin firewalling, sell to all the windows
weenies... ;)

With dedicated processors, maybe a IP/Sec accelerator would also be
cool, but I'd think a crypto accelerator for the main system would again
be saner here (unless, of course, the argument of the security domain
isolation is applied again).

Admittedely, one can solve all these differently, but it still might be
cool. ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

