Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263067AbTCWORo>; Sun, 23 Mar 2003 09:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbTCWORo>; Sun, 23 Mar 2003 09:17:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43682
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263067AbTCWORn>; Sun, 23 Mar 2003 09:17:43 -0500
Subject: Re: IDE todo list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030323034957.GA28820@vana.vc.cvut.cz>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
	 <20030322172453.GB9889@vana.vc.cvut.cz>
	 <1048360040.9221.23.camel@irongate.swansea.linux.org.uk>
	 <20030323034957.GA28820@vana.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048434078.10729.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 15:41:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 03:49, Petr Vandrovec wrote:
> This one fixes lockup, but I'm not actually sure that it is better
> than before, as both channels are downgraded to the PIO:

Its a real fix. We are in the IRQ handler so we cannot do disable_irq
because we deadlock waiting for ourselves to exit the interrupt handler

How we change mode downwards is a policy thing. We must avoid going into
MWDMA on error but going to UDMA0 is fine

Alan

