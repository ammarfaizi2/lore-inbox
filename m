Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWJBJy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWJBJy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWJBJy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:54:29 -0400
Received: from msr50.hinet.net ([168.95.4.150]:61630 "EHLO msr50.hinet.net")
	by vger.kernel.org with ESMTP id S1750898AbWJBJy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:54:27 -0400
Message-ID: <023b01c6e608$b8dc9af0$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <jgarzik@pobox.com>
References: <1159813476.2576.2.camel@localhost.localdomain> <20061001235338.566f4a67.akpm@osdl.org>
Subject: Re: [PATCH 2/5] Fix TX Pause bug (reset_tx, intr_handler)
Date: Mon, 2 Oct 2006 17:54:16 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When TxUnderrun happen, driver will re-enable tx. But during
this enable process, TxUnderrun maybe happen again. So driver
need to make sure Tx was actually enabled.

----- Original Message ----- 
From: "Andrew Morton" <akpm@osdl.org>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<jgarzik@pobox.com>
Sent: Monday, October 02, 2006 2:53 PM
Subject: Re: [PATCH 2/5] Fix TX Pause bug (reset_tx, intr_handler)


On Mon, 02 Oct 2006 14:24:36 -0400
Jesse Huang <jesse@icplus.com.tw> wrote:

> Fix TX Pause bug (reset_tx, intr_handler)

Please describe this bug more completely.    How does this patch solve it?


