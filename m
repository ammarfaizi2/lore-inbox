Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbSKBAtE>; Fri, 1 Nov 2002 19:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbSKBAtD>; Fri, 1 Nov 2002 19:49:03 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:3978 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265843AbSKBAtC>; Fri, 1 Nov 2002 19:49:02 -0500
Subject: Re: [PATCH] ide-scsi driver starts DMA too soon
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Khalid Aziz <khalid@fc.hp.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <E187lOK-0003Jd-00@lyra.fc.hp.com>
References: <E187lOK-0003Jd-00@lyra.fc.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 01:13:53 +0000
Message-Id: <1036199633.14825.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 23:39, Khalid Aziz wrote:
> ide-scsi driver starts DMA as soon as it writes the ATAPI PACKET command
> in command register and before sending the ATAPI command. This will
> cause problems on many drives. Right way to do it is to start DMA after
> sending the ATAPI command. I am attaching a patch that fixes this. This
> patch will allow many more CD-RW drives to work reliably in DMA mode 
> than do today.
> 
> Marcelo, please apply.

Marcelo this is in 2.5, and 2.4-ac. Khalid is certainly correct although
making such a change in -rc rather than a pre does mean it wants extra
thought

