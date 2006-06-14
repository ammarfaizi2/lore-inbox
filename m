Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWFNKm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWFNKm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 06:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWFNKm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 06:42:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29854 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751200AbWFNKm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 06:42:26 -0400
Subject: Re: [PATCH 2/2] NET: Accurate packet scheduling for ATM/ADSL
	(userspace)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Dangaard Brouer <hawk@comx.dk>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Jamal Hadi Salim <hadi@cyberus.ca>, netdev@vger.kernel.org,
       lartc@mailman.ds9a.nl, russell-tcatm@stuart.id.au, hawk@diku.dk,
       linux-kernel@vger.kernel.org
In-Reply-To: <1150278040.26181.37.camel@localhost.localdomain>
References: <1150278040.26181.37.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Jun 2006 11:57:05 +0100
Message-Id: <1150282625.3490.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-14 am 11:40 +0200, ysgrifennodd Jesper Dangaard Brouer:
> option to calculate traffic transmission times (rate table)
> over all ATM links, including ADSL, with perfect accuracy.

<Pedant>
Only if the lowest level is encoded in a time linear manner. If you are
using NRZ, NRZI etc at the bottom level then you may still be out...

</Pedant>

The other problem I see with this code is it is very tightly tied to ATM
cell sizes, not to solving the generic question of packetisation. I'm
not sure if that matters but for modern processors I'm also sceptical
that the clever computation is actually any faster than just doing the
maths, especially if something cache intensive is also running.

Alan

