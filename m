Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSGaJYl>; Wed, 31 Jul 2002 05:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSGaJYl>; Wed, 31 Jul 2002 05:24:41 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:42167 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317862AbSGaJYk>; Wed, 31 Jul 2002 05:24:40 -0400
Date: Wed, 31 Jul 2002 11:28:03 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: DEC PCI-to-PCI bridge problem ?
Message-ID: <20020731092803.GB6332@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a machine with (see lspci at the end):
	* intel motherboard (82443BX + 82371EB)
	* DEC PCI-to-PCI bridges (0x0022 0x1011)
	* several communication cards behind the bridges.

The DEC bridges are not recognized at boot (this is a 2.4.18-5 Red Hat 
SMP kernel):
	Unknown bridge resource 0: assuming transparent
	Unknown bridge resource 2: assuming transparent
	Unknown bridge resource 2: assuming transparent
	Unknown bridge resource 2: assuming transparent
	...
	Limiting direct PCI/PCI transfers.

The communication cards are used through a STREAMS driver, which
does a lot of iomem r/w short operations (read/writeb/l/w).

When several of those communication cards are used simultaneously,
the box becomes very loaded. 

Tracing this seems to point in the direction of errors in PCI 
transfers when accessing the communications cards over the bridges.

Does anyone encountered this problem before ? Is there a way to
"configure" the PCI-to-PCI bridge ?

Thanks.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
