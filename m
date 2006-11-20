Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbWKTJmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbWKTJmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 04:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWKTJmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 04:42:09 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18315 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S934038AbWKTJmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 04:42:08 -0500
Date: Mon, 20 Nov 2006 09:46:03 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Chris Snook <csnook@redhat.com>
Cc: Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, romieu@fr.zoreil.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] atl1: Revised Attansic L1 ethernet driver
Message-ID: <20061120094603.1d1e528a@localhost.localdomain>
In-Reply-To: <45614C80.5070303@redhat.com>
References: <20061119202817.GA29736@osprey.hogchain.net>
	<20061120011534.54b1e010@localhost.localdomain>
	<45614C80.5070303@redhat.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Be careful with :1 bitfields when working with hardware - the compiler
> > has more than one choice about how to pack them.
> 
> Lacking a spec, I'm not entirely sure what the original intent was, so 
> we're stuck with testing.  Is there a specific disambiguation technique 
> you recommend?

Assuming the driver works on x86 then you know how the bits are laid out.
You may find later you need to put in ifdefs for bitfield endian-ness as
we do in things like include/linux/ip.h

