Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262530AbTCMTJT>; Thu, 13 Mar 2003 14:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbTCMTJT>; Thu, 13 Mar 2003 14:09:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54735
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262530AbTCMTJQ>; Thu, 13 Mar 2003 14:09:16 -0500
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Willy Gardiol <gardiol@libero.it>, Jens Axboe <axboe@suse.de>,
       James Stevenson <james@stev.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.10.10303131048370.391-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10303131048370.391-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047587282.26978.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 13 Mar 2003 20:28:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 18:50, Andre Hedrick wrote:
> Alan,
> 
> Did we not fix this problem when HP addressed it with the ia64 stuff?

I've been working through a set of DMA problems. The PIO/DMA switching
timing out is fixed and has been for a while. I've very recently fixed a
race where we could get a command issued while resetting an interface.

With 2.4.x the reports I have make me think there are more races in
ide-scsi left. With 2.5.x its completely broken. Someone rewrote the
abort/reset handling, some other people rewrote the scsi core and the
result needs significant work yet

> Additionally I have finally found a long outstanding bug in the
> buildsgtable in ide-dma.c.  I just need to reverify the nature.  It has to
> do with the execution of the EOT bit in the last segment.  This would also
> explain why we are seeing expiry dma timeouts.

Cool
