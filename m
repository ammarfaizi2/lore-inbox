Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264982AbUEYRMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbUEYRMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUEYRMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:12:07 -0400
Received: from mail.skule.net ([216.235.14.165]:32643 "EHLO mail.skule.net")
	by vger.kernel.org with ESMTP id S264984AbUEYRJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:09:33 -0400
Date: Tue, 25 May 2004 13:09:31 -0400
From: Mark Frazer <mark@mjfrazer.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [OT] scatter-gather ops within host memory on a PC
Message-ID: <20040525170931.GE10775@mjfrazer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Fry: Where's Captain Bender? Off catastrophizing some other planet?
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to aggregate a bunch of ethernet packet payloads into a single
large buffer after examining the packet headers to determine the order of
the packets.  The data volume makes offloading this to a DMA controller
desirable.

Do PC chipsets have DMA controllers on them to do these scatter-gather
operations?  I know a lot of embedded SoC processors do, but am not
to familiar with the current PC chipsets.

I've glanced at the NFS code but haven't studied it a lot.
rxrpc/transport.c seems to copy some data around, so I assume that linux
uses the host processor to gather the individual ethernet packets into
pages that go into the page cache.

Are there any good books anyone would recommend on PC architecture?

thanks
-mark
-- 
The laws of science be a harsh mistress. - Bender
