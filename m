Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTBKVEI>; Tue, 11 Feb 2003 16:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTBKVEI>; Tue, 11 Feb 2003 16:04:08 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4736
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266114AbTBKVEH>; Tue, 11 Feb 2003 16:04:07 -0500
Subject: Re: 2.5.60 linking error with IDE-DMA disabled
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0302111207080.1173-100000@pcgl.dsa-ac.de>
References: <Pine.LNX.4.33.0302111207080.1173-100000@pcgl.dsa-ac.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044968542.12907.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Feb 2003 13:02:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 11:12, Guennadi Liakhovetski wrote:
> Hello
> 
> If I try to compile the kernel with IDE bus-mastering disabled (which,
> IIRC, worked on 2.4.x), I get the following error:
> 

Looks like the 2.5 makefile is broken. If you didnt include any IDE DMA
support them ide-dma.c should not have been linked into the kernel. 2.4.x
seems to get this right (though I have to fix modular IDE there yet). 
I'll have a look at the rest when I try and get 2.5.60 IDE back in sync
with the newer 2.4 code.

Alan

