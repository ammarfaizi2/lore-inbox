Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318869AbSHEUUa>; Mon, 5 Aug 2002 16:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318866AbSHEUUa>; Mon, 5 Aug 2002 16:20:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:21492 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318865AbSHEUU1>; Mon, 5 Aug 2002 16:20:27 -0400
Subject: Re: [PATCH] IDE udma_status = 0x76 and 2.5.30...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10208051249520.11932-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10208051249520.11932-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 22:42:20 +0100
Message-Id: <1028583740.18130.82.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 21:08, Andre Hedrick wrote:
> If we examine Table 2-3 of the Retired SFF-8038i rev 1.0 the only document
> to describe the behaviors of Bus Master IDE Status Register.
> It is a R/W field.

Andre - you are assuming the drive vendor follows 8038i and didnt just
leave the reserved bits random. At that point 0x76 makes reasonable
sense since its two DMA capable devices + a reserved bit and interrupt
with bus master error. 

Which simply means the code is still broken rather than anything truely
insane is happening. 

Alan

