Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292135AbSBAX2Q>; Fri, 1 Feb 2002 18:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292136AbSBAX2D>; Fri, 1 Feb 2002 18:28:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8204 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292135AbSBAX1q>; Fri, 1 Feb 2002 18:27:46 -0500
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
To: yoder1@us.ibm.com (Kent E Yoder)
Date: Fri, 1 Feb 2002 23:40:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <OFB91B46B3.DE7448D0-ON85256B53.0071158D@raleigh.ibm.com> from "Kent E Yoder" at Feb 01, 2002 02:53:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WnIP-0006TQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> handle adapters which write to one address and read from another for the 
> same variable?  I'm guessing it flushes all writes on a read?  This is 
> exactly what lanstreamer does, and I'm thinking this may have caused 
> problems before.

You probably want to get the actual documentation and read it - there are
a set of guarantees that I/O's do not pass one another. A read will not pass
a write for example. When you think about PCI as a message passing system
in both directions its generally a lot better for your head 8). The guarantees
are also defined in terms of PCI functions rather than a single port

Alan
