Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTIDUao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTIDUao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:30:44 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:36313 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262081AbTIDUae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:30:34 -0400
Subject: Re: 2.6.0-test4-mm5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Bruno T. Moura" <bruno.tavares@terra.com.br>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904102918.1bd354e1.bruno.tavares@terra.com.br>
References: <20030902231812.03fae13f.akpm@osdl.org>
	 <20030904102918.1bd354e1.bruno.tavares@terra.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062707366.22588.27.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 21:29:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-04 at 15:29, Bruno T. Moura wrote:
> Sep  4 09:53:26 pyro kernel: hde: Speed warnings UDMA 3/4/5 is not functional.
> Sep  4 09:53:26 pyro kernel: hde: dma_timer_expiry: dma status == 0x20
> Sep  4 09:53:26 pyro kernel: hde: DMA timeout retry

SATA mode on the ICH5 really wants to be driven by Jeff Garziks libata
SATA drivers not the ide layer code. The IDE code doesnt currently know
about cable detect not being valid on the SATA ports.

