Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271393AbTGQMO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 08:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271395AbTGQMO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 08:14:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29390
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271393AbTGQMOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 08:14:25 -0400
Subject: Re: [PATCH] (2.4.22-pre6 BK) New (IDE) driver: SGI IOC4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christopher Wedgwood <cw@sgi.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       wildos@sgi.com
In-Reply-To: <20030715222744.GA7478@taniwha.engr.sgi.com>
References: <20030715222744.GA7478@taniwha.engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058444787.8620.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jul 2003 13:26:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok the big problem I'm having with this code is understanding why most
of it even exists. Is this chip subtly different in some way I am
missing and so unable to use the generic PCI stuff or is most of the
copied code simply not needed.

As far as I can see the only "weirdness" it has is that the base
registers are off a non standard BAR. Thats something we already support
in the core IDE PCI code (see the cs5520 Kahlua driver in 2.6.0test)

Work was also done recently to allow clean wrapping of the generic DMA
stuff for devices that had to do custom setup around each IDE DMA (eg
HPT372N).

Basically - in what was is your controller not the same as generic MWDMA
capable IDE ?

