Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318275AbSHEAh6>; Sun, 4 Aug 2002 20:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318278AbSHEAh6>; Sun, 4 Aug 2002 20:37:58 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51706 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318275AbSHEAh6>; Sun, 4 Aug 2002 20:37:58 -0400
Subject: Re: 2.4.19: no DMA for IDE with Intel i845e
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1028507703.1486.11.camel@ixodes.goop.org>
References: <1028505657.1545.3.camel@ixodes.goop.org> 
	<1028512143.15495.45.camel@irongate.swansea.linux.org.uk> 
	<1028507703.1486.11.camel@ixodes.goop.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 02:59:56 +0100
Message-Id: <1028512796.15204.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 01:35, Jeremy Fitzhardinge wrote:
> -ac1 seems to work, but I don't really understand how.  I've looked
> through the drivers/ide and arch/i386 changes, but I don't see what
> makes the difference.

It cleans up the PCI resource allocations on the southbridge. The -ac3
tree knows about enabling a partially mapped device which is probably
the proper fix but means tweaking all the ports

