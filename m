Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSHPKpw>; Fri, 16 Aug 2002 06:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318291AbSHPKpw>; Fri, 16 Aug 2002 06:45:52 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:56048 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318290AbSHPKpv>; Fri, 16 Aug 2002 06:45:51 -0400
Subject: Re: ide-2.4.19-ac4.11.patch, late but stable
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Markus Plail <plail@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10208152353190.12468-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10208152353190.12468-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Aug 2002 11:48:03 +0100
Message-Id: <1029494883.31487.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-16 at 08:01, Andre Hedrick wrote:
> As much as I hate to concept of a DMA mempool, it looks like the direction
> to follow.  Games such as HOST<>DEVICE || feast<>famine of buffer streams
> appear to be the norm to push vast amounts of atapi-dma.  The alternative
> is to have device level request queues and have the queues carry the SG or
> PRD list for that portion.

We have mempool in 2.5 and backported so we can preallocate pools of
memory to meet some streaming requirement and then discard the entire
pool later.

What do you actually need ?

