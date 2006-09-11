Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWIKFd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWIKFd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWIKFd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:33:56 -0400
Received: from mms3.broadcom.com ([216.31.210.19]:6918 "EHLO MMS3.broadcom.com")
	by vger.kernel.org with ESMTP id S964857AbWIKFdy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:33:54 -0400
X-Server-Uuid: 450F6D01-B290-425C-84F8-E170B39A25C9
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: TG3 data corruption (TSO ?)
Date: Sun, 10 Sep 2006 22:33:45 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC093FB2C@NT-IRVA-0751.brcm.ad.broadcom.com>
In-Reply-To: <1157952348.31071.411.camel@localhost.localdomain>
Thread-Topic: TG3 data corruption (TSO ?)
thread-index: AcbVYsZ3gVT3paQqRlygFT4TWr+BcwAAHI0Q
From: "Michael Chan" <mchan@broadcom.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
cc: "Segher Boessenkool" <segher@kernel.crashing.org>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
X-TMWD-Spam-Summary: TS=20060911053346; SEV=2.0.2; DFV=A2006091101;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230322E34353034463339432E303032422D422D306A7671374D75736C6841666147687761704E7344673D3D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006091101_4.00.0004_4.0-8
X-WSS-ID: 691A2AB0230451041-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> I've done:
> 
> #define tw32_rx_mbox(reg, val)	do { wmb();
tp->write32_rx_mbox(tp, reg, val); } while(0)
> #define tw32_tx_mbox(reg, val)	do { wmb();
tp->write32_tx_mbox(tp, reg, val); } while(0)
> 

That should do it.

I think we need those tcpdump after all.  Can you send it to me?

