Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUFKGRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUFKGRm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 02:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUFKGRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 02:17:42 -0400
Received: from ee.oulu.fi ([130.231.61.23]:60588 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261913AbUFKGRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 02:17:37 -0400
Date: Fri, 11 Jun 2004 09:17:30 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Pavel Machek <pavel@ucw.cz>
Cc: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Dealing with buggy hardware (was: b44 and 4g4g)
Message-ID: <20040611061730.GA8081@ee.oulu.fi>
References: <20040531202104.GA8301@ee.oulu.fi> <20040605200643.GA2210@ee.oulu.fi> <20040605131923.232f8950.davem@redhat.com> <20040609122905.GA12715@ee.oulu.fi> <20040610200504.GG4507@openzaurus.ucw.cz> <20040610203442.GA27762@ee.oulu.fi> <20040610211217.GA6634@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040610211217.GA6634@elf.ucw.cz>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 11:12:17PM +0200, Pavel Machek wrote:
> Okay, this is probably other problem. When the bug hit, what are the symptoms?
Total immediate crash without an oops. When the RX ring skbufs are allocated
with GFP_DMA receives work, but any transmits from > 1GB cause a link
down/link up (which is just about all of them). With GPF_DMA bounce
buffers those start working too.

> > (Or the issue isn't fully understood yet, figuring out what breaks and what
> > doesn't was basically just trial and error :-/ )
> 
> Can you try the driver from broadcom? bcom4400, or how is it
> called. Its extremely ugly, but might get this kind of stuff right...
Tried that, it breaks with 4:4 and >1GB in exactly the same way :-)
