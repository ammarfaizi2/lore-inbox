Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUIANbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUIANbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUIANbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:31:10 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13451 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266704AbUIAN1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:27:37 -0400
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: lkml@einar-lueck.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200409011441.10154.elueck@de.ibm.com>
References: <200409011441.10154.elueck@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094041525.2376.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 13:25:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 13:41, Einar Lueck wrote:
> The following small patch (applies to BK head) addresses issues relevant for transparent NIC failover (especially in case of NFS). It allows to configure on a per device basis via sysctl an IP address (Source Virtual IP Address - Source VIPA) that is set as IP source address for all connections for which no bind has been applied. ?To allow for NIC failover one then just needs:
> 1. A dummy-Device set up with the Source VIPA
> 2. Outbound routes via both/all redundant NICs for the relevant packets (more precisely: dynamic routing with for example ZEBRA)
> 3. Routes to the Source VIPA on the relevant router having the IPs of the redundant NICs configured as gateways (more precisely: dynamic routing with for example ZEBRA)
> Dynamic routing is mandatory as it is necessary that dead routes (e.g. NIC dead) are removed at the relevant router.

Is there anything here that cannot already be done by the ip route
command and iptables nat ?


