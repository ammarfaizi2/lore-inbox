Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbSL3MTG>; Mon, 30 Dec 2002 07:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbSL3MTG>; Mon, 30 Dec 2002 07:19:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44416
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266932AbSL3MTF>; Mon, 30 Dec 2002 07:19:05 -0500
Subject: Re: How much we can trust packet timestamping
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: uaca@alumni.uv.es
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021230112838.GA928@pusa.informat.uv.es>
References: <20021230112838.GA928@pusa.informat.uv.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 13:09:03 +0000
Message-Id: <1041253743.13097.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 11:28, uaca@alumni.uv.es wrote:
> Hi all
> 
> IMHO The problem is quite complicated because
> 
> + common hardware is not designed for real time:
> 
> 	- sends multiple PDUs within one interrupt, and can be delayed
> 	- Host adapter bus & infraestructure is not designed to garantee latency
>   	etc...

The packet can be timestamped by the hardware receiving as well as by
the kernel netif_rx code. This is actually intentional and there is
hardware that supports doing IRQ raise time sampling which the driver
can then use to get very accurate data.

Alan

