Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWHVBUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWHVBUQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 21:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWHVBUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 21:20:15 -0400
Received: from msr34.hinet.net ([168.95.4.134]:65449 "EHLO msr34.hinet.net")
	by vger.kernel.org with ESMTP id S932070AbWHVBUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 21:20:13 -0400
Message-ID: <00bd01c6c588$afdedbc0$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <akpm@osdl.org>
References: <1155841445.4532.10.camel@localhost.localdomain> <44E5A425.8020200@pobox.com>
Subject: Re: [PATCH 2/6] IP100A Fix Tx pause bug
Date: Tue, 22 Aug 2006 09:17:08 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<akpm@osdl.org>
Sent: Friday, August 18, 2006 7:27 PM
Subject: Re: [PATCH 2/6] IP100A Fix Tx pause bug

(1)
>> + iowrite8(127, ioaddr + TxDMAPollPeriod);
>> +
>
> what does the value 127 represent?

127 is polling period of Tx DMA to watch if there any packet need to send.
The 127 means 127*320ns.

(2)
> DownCounter should not be written unconditionally.  Consider shared
> interrupts, where sundance performs no work, and handled==0.

DownCount is a the register that we can use for timer interrupt. When the
value of  DownCount from 1 count down to 0 , IP100A will issue an interrupt.


